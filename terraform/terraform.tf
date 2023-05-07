terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    buildkite = {
      source  = "buildkite/buildkite"
      version = "0.14.0"
    }
  }

  required_version = "~> 1.3"
}
