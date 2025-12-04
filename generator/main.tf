# main.tf
terraform {
  required_version = ">= 0.12"
}

# Generate a random string
resource "random_string" "example" {
  length  = 59
  special = true
  upper   = true
  lower   = true
  numeric = true
}

# Create a local file with the random string
resource "local_file" "example" {
  content  = "Generated random string: ${random_string.example.result}\nTimestamp: ${timestamp()}"
  filename = "${path.module}/output4.txt"
}

# Output the random string
output "random_value" {
  value       = random_string.example.result
  description = "The generated random string"
}

output "file_path" {
  value       = local_file.example.filename
  description = "Path to the generated file"
}
