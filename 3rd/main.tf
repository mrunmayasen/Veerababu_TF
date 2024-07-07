resource "aws_s3_bucket" "remote" {
    bucket = "remote-state-tfmrunmaya"
  
}
#resource "aws_s3_bucket_acl" "remote" {
 # bucket = aws_s3_bucket.remote.id
  #acl    = "private"
#}

resource "aws_s3_bucket_versioning" "versioning_remote" {
  bucket = aws_s3_bucket.remote.id
  versioning_configuration {
    status = "Enabled"
  }
}