variable "environment" {
  type    = string
  default = "test"
}

resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/vpc/id"
  type  = "String"
  value = "vpc-test-001"

  tags = {
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "vpc_cidr" {
  name  = "/${var.environment}/vpc/cidr"
  type  = "String"
  value = "10.0.0.0/16"

  tags = {
    Environment = var.environment
  }
}

output "vpc_id" {
  value = aws_ssm_parameter.vpc_id.value
}

output "vpc_cidr" {
  value = aws_ssm_parameter.vpc_cidr.value
}
