resource "aws_security_group" "example_sg" {
  name        = "example_security"
  description = "Allow all traffic from all IPv4 addresses"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all inbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
