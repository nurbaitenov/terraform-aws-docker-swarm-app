resource "aws_instance" "manager" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.swarm.id]

  subnet_id = aws_subnet.public1.id

  user_data = <<E0F
    #!/bin/bash
    dnf update -y
    dnf install docker -y 
    systemctl enable docker 
    systemctl start docker 
    usermod -aG docker ec2-user

    # Wait until Docker is ready
    until docker info >/dev/null 2>&1; do
      sleep 2
    done

    PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
    docker swarm init --advertise-addr $PRIVATE_IP
    E0F

  tags = {
    Name = "dockerswarm"
  }
}