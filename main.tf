# Specify the provider (in this case, AWS)
provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "./ansible/private_key.pem"
}

resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = tls_private_key.example.public_key_openssh
}

# Define an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  key_name      = aws_key_pair.example.key_name
}

resource "aws_instance" "example1" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  key_name      = aws_key_pair.example.key_name
}

# Output the public IP address of the created instance
output "public_ip" {
  value = aws_instance.example.public_ip
}
output "public_ip1" {
  value = aws_instance.example1.public_ip
}
