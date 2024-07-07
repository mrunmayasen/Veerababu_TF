terraform {
  backend "s3" {
    bucket = "remote-state-tfmrunmaya"
    key    = "tfstate"
    region = "us-east-2"
    
  }
}