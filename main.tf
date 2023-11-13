# Specify the provider (in this case, AWS)
provider "aws" {
  region = "us-east-1"
}

# Define an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
}

resource "aws_instance" "example1" {
  ami           = "ami-06aa3f7caf3a30282"
  instance_type = "t2.micro"
}

# Output the public IP address of the created instance
output "public_ip" {
  value = aws_instance.example.public_ip
}
output "public_ip" {
  value = aws_instance.example1.public_ip
}
