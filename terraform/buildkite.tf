resource "buildkite_pipeline" "xyz_cloud" {
    name = "xyz-api"
    repository = "https://github.com/mattvaughan/xyz-cloud.git"
    steps = file("../.buildkite/pipeline.yml")
}

module "buildkite_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "buildkite-${random_string.suffix.result}-vpc"

  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}

resource "aws_instance" "buildkite" {
  count = 2

  # Ubuntu
  ami           = "ami-0df58e89a1ffef81c"
  instance_type = "t3.micro"
  subnet_id     = element(module.buildkite_vpc.public_subnets, 1)
  iam_instance_profile = aws_iam_instance_profile.buildkite_profile.name

  user_data = <<-EOF
    #!/bin/bash
    curl -fsSL https://keys.openpgp.org/vks/v1/by-fingerprint/32A37959C2FA5C3C99EFBC32A79206696452D198 | sudo gpg --dearmor -o /usr/share/keyrings/buildkite-agent-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/buildkite-agent-archive-keyring.gpg] https://apt.buildkite.com/buildkite-agent stable main" | sudo tee /etc/apt/sources.list.d/buildkite-agent.list
    sudo apt-get update && sudo apt-get install -y buildkite-agent docker docker-compose curl awscli
    sudo sed -i "s/xxx/${var.buildkite_agent_token}/g" /etc/buildkite-agent/buildkite-agent.cfg
    sudo systemctl enable buildkite-agent && sudo systemctl start buildkite-agent
    sudo usermod -aG docker ubuntu
    sudo usermod -aG docker buildkite-agent
    sudo mkdir -p /home/buildkite-agent
    sudo chown -R buildkite-agent /home/buildkite-agent
    sudo usermod -d /home/buildkite-agent buildkite-agent
    sudo systemctl enable docker && sudo systemctl start docker
    sudo -u buildkite-agent docker login --username ${var.dockerhub_user} --password ${var.dockerhub_password}
    sudo systemctl restart buildkite-agent
    sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo chmod +x ./kubectl
    sudo cp ./kubectl /usr/bin/kubectl
    sudo -u buildkite-agent aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}
    sudo mkdir /kube-info && sudo echo "${module.eks.cluster_endpoint}" > /kube-info/endpoint
    sudo chown -R buildkite-agent /kube-info
    sudo curl -Lo /usr/local/bin/tk https://github.com/grafana/tanka/releases/latest/download/tk-linux-amd64
    sudo chmod a+x /usr/local/bin/tk
    sudo curl -Lo /usr/local/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/latest/download/jb-linux-amd64
    sudo chmod a+x /usr/local/bin/jb
  EOF

  tags = {
    Name = "buildkite"
  }
}

resource "aws_iam_role" "buildkite_k8s_deployer" {
  name = "buildkite_k8s_deployer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "k8s_deploy" {
  name = "k8s_deploy"
  path = "/"
  description = "To get kubeconfig"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:*",
        ],
        Resource = "${module.eks.cluster_arn}"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "buildkite_attachment" {
  name = "buildkite_attachment"
  roles = [aws_iam_role.buildkite_k8s_deployer.name]
  policy_arn = aws_iam_policy.k8s_deploy.arn
}

resource "aws_iam_instance_profile" "buildkite_profile" {
  name = "buildkite_profile"
  role = aws_iam_role.buildkite_k8s_deployer.name
}
