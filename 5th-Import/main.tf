resource "aws_instance" "import" {
  ami = "ami-0862be96e41dcbf74"
  instance_type = "t2.micro"
  tags = {
    name = "import"
  }
}
