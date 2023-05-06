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
- Jsonnet Bundler
- AWS Cli
- AWS Credentials in Environment variables
- Use Nix to wrap all this up?

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
