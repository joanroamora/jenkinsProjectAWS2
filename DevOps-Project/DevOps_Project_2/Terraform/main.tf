data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "basic_security" {
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
}

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_instance" "dev_machine" {
  ami = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  #key_name = "jroamkeys"
  key_name = "${var.keypair}"
  vpc_security_group_ids = [aws_security_group.basic_security.id]

  tags = {
    Environment = "dev"
    Name = "${var.name}-server"
  }
}


