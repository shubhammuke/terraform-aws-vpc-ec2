// AWS EC2 Instance Creation
resource "aws_instance" "web" {
  ami           = "ami-04a5a6be1fa530f1c"
  instance_type = "t3.micro"
  key_name = aws_key_pair.loginkey.key_name
  security_groups = [aws_security_group.WebSG.id]
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "WebServer"
  }
}

// Key Pair Ctreation For SSH Login
resource "aws_key_pair" "loginkey" {
  key_name   = "WebSrv"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIPQJwOcQGQCPY6sFxh4SRDyJc2nLIWDkPwha7RIp3+eg89DJIlnKW1Nk91VImJ8F7310uIlRIQ0KX4eLeVQ6QWJOTfZY0RbFmcnqwM5SB7G96XQ5YKAEtjDryCiq/E7LM2ddp09foU5rBZhuiyGmfFuvZdWOj2BHWYkVvlApzgnOioFSVzqUAeky4jG/8wsfGq87MqZ+SLZL6oN3EO1crOjhr//UmOoKaXuq7eSFdiFnC/jmSn9+NcoG8ZqfzyZK6dq75g5ALhHE886J9ys6BFXxtZvw2l34NyRwVDFbQjbJaDKUhnejg6g2bky01AOqlLsJK+xO6lUhG+gaMGl/2dxa3Cz6QOoSJvmft6c/7pY5i6iir61hcPVuQvUxVYUEvLJT0v01b6KUlLelpxmJqrbfIqp8j2j8i9vR3fhI+TUCxm72ZFFnj4zTxt6Is4PwohRqi9rwBKLmk0Rc5YnFCbgdIybjyUfvD3y8EreC+ucvCNEcaXr+02izdgHaSfG8= shubh@Shubham"
}


// Elastic IP Attachent
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.web.id
  domain   = "vpc"
}
