# terraform {
#   backend "s3" {
#     bucket = "terraform-backen-for-dockerswarmapp"     # create bucket manually on aws console
#     key    = "us-east-1/main"
#     region = "us-east-1"
#      dynamodb_table = "terraform-locks"
#      encrypt        = true
#   }
# }


# For terraform LOCKING use DynamoDB

# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = "terraform-locks"
#   billing_mode = "PAY_PER_REQUEST"

#   hash_key = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "Terraform State Lock"
#     Environment = "dev"
#   }
# }


# creates terraform state VERSIONING

# resource "aws_s3_bucket_versioning" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }