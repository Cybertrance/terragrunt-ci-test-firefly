variable "vpc_id" {
  type    = string
  default = "vpc-mock-1"
}

variable "environment" {
  type    = string
  default = "test"
}

resource "aws_ssm_parameter" "db_endpoint" {
  name  = "/${var.environment}/database/endpoint"
  type  = "String"
  value = "db.example.com:5432"

  tags = {
    Environment = var.environment
  }
}

resource "aws_ssm_parameter" "db_engine" {
  name  = "/${var.environment}/database/engine"
  type  = "String"
  value = "postgres"

  tags = {
    Environment = var.environment
  }
}

output "db_endpoint_param" {
  value = aws_ssm_parameter.db_endpoint.name
}

output "db_engine_param" {
  value = aws_ssm_parameter.db_engine.name
}
