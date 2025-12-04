resource "null_resource" "vpc" {
  triggers = {
    vpc_id      = "vpc-test-${timestamp()}"
    environment = "test"
  }
}

output "vpc_id" {
  value = null_resource.vpc.triggers.vpc_id
}

output "vpc_cidr" {
  value = "10.0.0.0/16"
}

