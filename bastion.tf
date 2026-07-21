resource "aws_instance" "bastion" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  key_name                    = aws_key_pair.main.key_name
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "bastion"
    Role = "bastion"
  }

  user_data = <<-EOF
#!/bin/bash
dnf update -y
dnf install -y git vim htop
EOF
}