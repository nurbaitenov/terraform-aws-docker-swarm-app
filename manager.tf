resource "aws_instance" "example" {
  ami           = var.image_id
  instance_type = var.instance_type

  vpc_security_group_ids= [aws_security_group.swarm.id]

  subnet_id =  var.aws_subnet.public_subnet1.id

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

    docker swarm init
    E0F

  tags = {
    Name = "dockerswarm"
  }
}