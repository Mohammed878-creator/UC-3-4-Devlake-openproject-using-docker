terraform {
  backend "s3" {
    bucket       = "usecase2-2tier-arch"
    key          = "terraform.tfstate"
    region       = "ca-central-1"
    encrypt      = true
    use_lockfile = true
  }
}