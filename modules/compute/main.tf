
resource "aws_security_group" "ec2-sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

resource "aws_instance" "my_ec2" {
  ami           = var.ec2_ami 
  instance_type = var.ec2_instance_type           

  subnet_id                   = var.public_subnet_id_1
  vpc_security_group_ids      = [aws_security_group.ec2-sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 20 
  }

  key_name = "tst-nginx"

  tags = {
    Name = "${var.project_name}-ec2"
  }
}