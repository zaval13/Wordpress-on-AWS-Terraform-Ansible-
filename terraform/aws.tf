provider "aws" {
region = "us-east-2"
}

resource "aws_instance" "my_aws" {
  ami = "ami-0233c2d874b811deb"
  instance_type = "t2.micro"
  key_name         = "awskey"
  vpc_security_group_ids = [aws_security_group.my_webserver1.id]
    
  tags = {
      Name = "Wordpress1"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.my_aws.id
  vpc = true
}

resource "aws_security_group" "my_webserver1" {
  name        = "webserver security group1"
  description = "security group"
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  } 

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  

  tags = {
    Name = "security group"
  }
}
