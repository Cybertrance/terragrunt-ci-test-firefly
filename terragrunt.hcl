# Root terragrunt.hcl with common configuration
# Skip terraform execution in root - child modules override this
skip = true

locals {
  environment = "test"
  aws_region  = "us-east-1"
  # Configure your S3 bucket name for Terraform state storage
  state_bucket = "dm-terraform-state-test"
  # Configure your DynamoDB table name for state locking
  lock_table = "terraform-state-lock"
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    bucket         = local.state_bucket
    key            = "terragrunt/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = local.lock_table
    # Note: DynamoDB locks persist until manually released with 'terraform force-unlock'
    # If a CI run is killed, the lock remains and subsequent runs will detect it
  }
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Generate provider configuration
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  
  # AWS credentials are configured via:
  # - AWS CLI: ~/.aws/credentials
  # - Environment variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
  # - IAM roles (when running on EC2 or in CI/CD with proper setup)
}
EOF
}

# Common inputs to pass to all child modules
inputs = {
  aws_region  = local.aws_region
  environment = local.environment
}
