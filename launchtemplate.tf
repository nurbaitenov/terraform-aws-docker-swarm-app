resource "aws_launch_template" "workers" {
  name_prefix   = var.name_prefix
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.key_name

  vpc_security_group_ids = [aws_security_group.swarm.id]

  depends_on = [
    aws_instance.manager
  ]

  user_data = base64encode(<<-EOF
#!/bin/bash
dnf update -y
dnf install docker -y

systemctl enable docker
systemctl start docker
EOF
  )
}