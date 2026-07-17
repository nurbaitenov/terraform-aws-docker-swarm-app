resource "aws_instance" "example" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"

  vpc_security_groups =

  subnet_id =  

  user_data = << E0F
    "#!/bin/bash
    dnf update -y
    dnf install docker -y 
    systemctl enable docker 
    systemctl start docker 
    docker swarm init"
    E0F

  tags = {
    Name = "dockerswarm"
  }
}