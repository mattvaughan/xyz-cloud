# xyz-cloud
XYZ Cloud Demo

# Prerequisites (will automate some of this)
- Bash
- Docker
- Docker Compose
- AWS Credentials
- Terraform
- Kubectl
- Tanka
- AWS Cli
- AWS Credentials in Environment variables

# Details
- Pretty print json
- Swagger
- Easy `docker-compose` compilation and run
- Multi-stage docker build to remove build deps

# Potential Improvements
- Restore .NET deps in separate step

# Guides Used
- https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks

# Notes
- After terraform apply, configure `kubectl` with 
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
