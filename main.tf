# I want Terraform to download at least one provider, so we can test different ways
# of adding providers to Docker containers. 
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "local_file" "test_file" {
  content  = "foo"
  filename = "${path.module}/foo.bar"
  # Bad arguments will be caught by `terraform validate`, which we run as
  # part of building the Docker container. 
  # asdf = "xyz"
}
