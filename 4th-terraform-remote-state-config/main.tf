resource "aws_instance" "name" {
    ami = "ami-0862be96e41dcbf74"
    instance_type = "t2.micro"    
    key_name = "myohiokey"

    tags = {                      
      name = "myEC2"              
    }

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
