# create vpc

resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "cust_vpc"
    }
  
}
# create subnet
resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"

}

#create IG and attach to vpc
resource "aws_internet_gateway" "dev" {
    vpc_id = aws_vpc.dev.id
       
    }


#create RT and configure IG
resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.dev.id
    route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.dev.id 
}
}
resource "aws_route_table_association" "dev" {
    subnet_id = aws_subnet.dev.id
    route_table_id = aws_route_table.dev.id
  
}

#create sg


resource "aws_security_group" "allow_tls" {
    name = "allow_tls"
    vpc_id = aws_vpc.dev.id
    tags = {
        name = "dev-sg"
    }
  
  ingress {
    description = "TLS from VPC"
    protocol  = "tcp"
    self      = true
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    protocol  = "tcp"
    self      = true
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type    
    key_name = var.key_name
    subnet_id = aws_subnet.dev.id
    security_groups = [aws_security_group.allow_tls.id]

    tags = {                      
      name = "myEC2"              
    }
}