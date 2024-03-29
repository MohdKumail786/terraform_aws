resource "aws_security_group" "uat_stack_sg" {
  vpc_id      = aws_vpc.uat.id
  name        = "uat-stack-sg"
  description = "Sec Grp for UAT ssh"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "allow-web&ssh-traffic"
  }
}
