resource "aws_instance" "manager" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.swarm.id]

  subnet_id = aws_subnet.public1.id

  user_data = file("${path.module}/manager.sh")

  tags = {
    Name = "swarm-manager"
    Role = "manager"
  }
}