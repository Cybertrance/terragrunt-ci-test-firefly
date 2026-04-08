variable "vpc_id" {
  type    = string
  default = "vpc-mock-1"
}

variable "environment" {
  type    = string
  default = "test"
}

resource "random_string" "example" {
  length  = 59
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "aws_s3_bucket" "generated_output" {
  bucket = "dm-generator-output-${var.environment}"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_object" "generated_file" {
  bucket  = aws_s3_bucket.generated_output.id
  key     = "output.txt"
  content = "Generated random string: ${random_string.example.result}"

  tags = {
    Environment = var.environment
  }
}

output "random_value" {
  value       = random_string.example.result
  description = "The generated random string"
}

output "bucket_id" {
  value       = aws_s3_bucket.generated_output.id
  description = "The S3 bucket for generated output"
}
