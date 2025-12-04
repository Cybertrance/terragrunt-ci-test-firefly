include "root" {
  path = find_in_parent_folders()
}

# Override the skip from root - we want to run terraform here
skip = false

terraform {
  source = "."
}

dependency "vpc" {
  config_path = "../vpc"
  
  mock_outputs = {
    vpc_id = "vpc-mock-123"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate"]
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}

