resource "aws_s3_bucket" "thala" {
  bucket = "kumariauntyyyyyyyyy1"
}
 
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}

 terraform {
backend "s3" {
    bucket         = "kumariauntyyyyyyyyy1"  # Name of the S3 bucket where the state will be stored.
    region         =  "us-east-1"
    key            = "terraform.tfstate" # Path within the bucket where the state will be read/written.
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking, note: first run day-4-bckend resources then day-5-backend config
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
}
}

