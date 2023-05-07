variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "buildkite_agent_token" {
  description = "Buildkite Token"
  type        = string
}

variable "dockerhub_user" {
  description = "Docker Hub User"
  type        = string
}

variable "dockerhub_password" {
  description = "Docker Hub Password"
  type        = string
}
