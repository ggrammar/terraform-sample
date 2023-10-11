# terraform-sample

I actually have a fair amount of experience with terraform, so this probably won't be a super instructional repo for beginners.

# Installation

## Terraform CLI

I don't want to install much locally, so I'm running the Terraform CLI inside a Docker container:

```
alias terraform() { docker run -w /root -v $(pwd):/root hashicorp/terraform:1.6.1 $@ }
```

## Build Deployer

We check the code and config to ensure it's valid here. See the Dockerfile for more detatils.

```
docker build . -t tf-deployer
```

## Run Deployer

This runs very quickly for local filesystem operations! A pleasant surprise after running against cloud resources for so long. 

```
docker run tf-deployer plan
docker run tf-deployer apply -auto-approve
```

# Answered Questions

## What's the best way to containerize Terraform for easy deployment?

As much as possible, we just want Terraform to do deployment things at deployment time.

Downloading providers and validation should happen at build time. We accomplish this by running `terraform init` and `terraform validate` when building the Docker container. 

It would be neat to run `terraform plan` as an intermediate build step, before deployment, to ensure that the deployment will be valid against the actual infrastructure. But, this gives our build plan access to our actual environment, which is less than ideal. 

# Open Questions

What's the best way to run Terraform in a CI/CD system?
 - Seems like using -out to generate plan files keeps things stable.
	- How do we switch between environments like this? Can we provide variables correctly?
 - What's the difference between doing this and pinning all of the build dependencies in a container?
 - How will we make providers available in the container?
 - I should add a terraform build/deploy to my Jenkins or Concourse sampler

# TODO

Use a persistent backend like S3, or a file on disk. 

