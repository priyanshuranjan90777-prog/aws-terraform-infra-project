terraform {
  backend "s3" {
    bucket       = "terraform-state-391732005521-priyanshu-20261015"
    key          = "terraform/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}