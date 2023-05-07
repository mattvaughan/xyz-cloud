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

# Details
- Pretty print json
- Swagger
- Easy `docker-compose` compilation and run
- Multi-stage docker build to remove build deps
- Terraform creates pipeline as well
- Dynamically generate karate buildkite step

# Potential Improvements
- Restore .NET deps in separate step

# Guides Used
- https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks
- https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html

# Notes
- After terraform apply, configure `kubectl` with 
```
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
- To start Buildkite agent locally
```
docker run -e BUILDKITE_AGENT_TOKEN="<your-key>" buildkite/agent
```
- Set tk endpoint
```
tk env set environments/default --server=https://127.0.0.1:6443`
```
- Pushing to docker hub
```
docker tag local-image:tagname new-repo:tagname
docker push mvon38/xyz:tagname
```
- Remember to parmaterize terraform for things specific to me
- Set BUILDKITE_API_TOKEN and BUILDKITE_ORGANIZATION for Buildkite terraform provider
- Process would change if I could split into multiple repos
- Optmized for "one-click"
- Just using latest for tags
- Install github buildkite hooks
- Check on karate false positives
