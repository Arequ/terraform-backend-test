# Configure the bucket that will host the tfstate files.

provider "aws" {
    region = "us-east-1"
}
resource "aws_s3_bucket" "tf-state-bucket" {
    bucket = "tf-backend-atwo"  
}

resource "aws_s3_bucket_acl" "tf-bucket-acl" {
    bucket = aws_s3_bucket.tf-state-bucket.id
    acl    = "private"
}
/* NOTE:
For critical and/or production S3 objects, do not create a bucket, 
enable versioning, and create an object in the bucket within the 
same configuration. Doing so will not allow the AWS-recommended 
15 minutes between enabling versioning and writing to the bucket.
*/
/*
resource "aws_s3_bucket_versioning" "tf-bucket-versioning" {
    bucket = aws_s3_bucket.tf-state-bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}
*/
