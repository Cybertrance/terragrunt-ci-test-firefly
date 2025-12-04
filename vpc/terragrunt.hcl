include "root" {
  path = find_in_parent_folders()
}

# Override the skip from root - we want to run terraform here
skip = false

terraform {
  source = "."
}

