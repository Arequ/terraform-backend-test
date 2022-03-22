# configure dynamodb

resource "aws_dynamodb_table" "tf-locks-db" {
    name = "dynamodb-tf-lock-state"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}