# Specify the provider (in this case, AWS)
provider "aws" {
  region = "us-west-2"
}

# Define an AWS EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# Output the public IP address of the created instance
output "public_ip" {
  value = aws_instance.example.public_ip
}
