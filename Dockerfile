FROM hashicorp/terraform:1.6.1

WORKDIR /root

# Add our Terraform code and CLI config.
ADD ./main.tf /root/main.tf
ADD ./terraformrc /root/.terraformrc


# In a complex environment with many different terraform-based containers, it can be
# useful to `terraform init` in one directory, then `terraform apply` in another. 
# 
# Terraform normally uses the working directory for downloading providers during `init`,
# and reading providers during `apply`. We can change this behavior.
#
# First, mirror the providers to an alternate directory with `terraform providers mirror`.
# https://developer.hashicorp.com/terraform/cli/commands/providers/mirror
# 
# Then, 

# https://developer.hashicorp.com/terraform/cli/config/config-file#provider-installation

# It's possible to `terraform init` and `terraform apply` from different directories.
# 
# If we wanted to run `terraform init` and `terraform apply` from different directories, 
# we could run `terraform providers mirror`
RUN ["terraform", "init"]

# We can only validate once we have providers installed.

RUN ["terraform", "validate"]

# TODO: Use -plugin-dir for applying changes
