variable "vpc_id" {
  type    = string
  default = "vpc-mock-1"
}

resource "time_sleep" "database_delay" {
  create_duration = "120s"
  
  triggers = {
    db_id = "db-test-${timestamp()}"
  }
}

resource "null_resource" "database" {
  triggers = {
    db_id      = "db-test-${timestamp()}"
    vpc_id     = var.vpc_id
    db_engine  = "postgres"
    delay      = time_sleep.database_delay.id
  }
}

output "db_id" {
  value = null_resource.database.triggers.db_id
}

output "db_endpoint" {
  value = "db.example.com:5432"
}

