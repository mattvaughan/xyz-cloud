# xyz-cloud
XYZ Cloud Demo

## Prerequisites
- You've signed up for a Buildkite account and set these env vars
  - `BUILDKITE_API_TOKEN="<your-buildkite-api-token>"`
  - `BUILDKITE_ORGANIZATION="<your-buildkite-org>"`
  - `TF_VAR_buildkite_agent_token="<your-buildkite-agent-token>"`


- You've signed up for an AWS account and set these env vars
  - `AWS_ACCESS_KEY_ID="<your-key-id>"`
  - `AWS_SECRET_ACCESS_KEY="<your-access-key>"`
  - `AWS_REGION="us-east-2"`

- You've signed up for Docker Hub and set these env vars
  - `TF_VAR_dockerhub_user="<your-docker-hub-user>"`
  - `TF_VAR_dockerhub_password="<your-docker-hub-password>"`

## Dependencies
These are the tools you'll need to interact with this project. If you'd like, you can install [Nix](https://nixos.org/download.html) on your system and run `nix-shell` in the root of the repo to get an environment with the tools installed, though you still may need to configure the docker daemon and groups if you don't have that on your system already.

- Bash
- Docker
- Docker Compose
- AWS Credentials
- Terraform
- Kubectl
- Tanka
- Jsonnet Bundler
- AWS Cli

## Running locally

```
docker compose run message-api
```

## Running in production

Apply the terraform!

This will create over 80 resources inclduing:
- EKS Cluster
- Buildkite Pipeline
- Buildkiet Agent in EC2
- Tanka Configuration

```
cd terraform
terraform apply
git commit -am "Adding generate tanka config" && git push
```

This does not add the web hook to the Github repo, so you'll need to do that manually. Alternatively, you can just click `New Build` to kickoff the deployment.

You should be able to see the application runing in EKS now! Grab the URL of your application from the Buildkite pipeline annotation, and checkout the endpoint `/Message`

# Other Notes
- After terraform apply, configure `kubectl` to interact with EKS:
```
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

# Notes
- Remember to parmaterize terraform for things specific to me
- Process would change if I could split into multiple repos
- Optmized for "one-click"
- Check on karate false positives
