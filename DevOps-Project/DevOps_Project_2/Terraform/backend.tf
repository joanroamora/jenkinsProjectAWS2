terraform {
  backend "s3" {
    bucket = "jrrm-terraform-statefile"
    key = "server_name/statefile"
    region = "us-east-2"
  }
}  
