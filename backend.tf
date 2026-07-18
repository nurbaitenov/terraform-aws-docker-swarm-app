terraform {
  backend "s3" {
    bucket = "terraform-backen-for-dockerswarmapp"
    key    = "us-east-1/main"
    region = "us-east-1"
  }
}