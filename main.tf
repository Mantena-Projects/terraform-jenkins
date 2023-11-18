# Specify the provider (in this case, AWS)
provider "aws" {
  region = "us-east-1"
}

# Generate a TLS private key
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an AWS key pair using the generated private key
resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = tls_private_key.example.public_key_openssh
}

provisioner "local-exec" {
    command = "echo '${tls_private_key.example.private_key_pem}' > ./ansible/private_key.pem"
  }

# Define an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
}

# Define another AWS EC2 instance with a different name
resource "aws_instance" "example1" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name
}

# Output the public IP addresses of the created instances
output "public_ip" {
  value = aws_instance.example.public_ip
}

output "public_ip1" {
  value = aws_instance.example1.public_ip
}
