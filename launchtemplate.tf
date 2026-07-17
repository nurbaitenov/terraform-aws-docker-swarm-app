resource "aws_launch_template" "foobar" {
  name_prefix   = var.name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type
  user_data = << E0F
  
    #!/bin/bash

    dnf update -y
    dnf install docker -y
    systemctl enable docker
    systemctl start docker
    E0F
}