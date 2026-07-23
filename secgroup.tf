resource "aws_security_group" "manager" {
  name        = "manager-sg"
  description = "Security group for Docker Swarm Manager"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from my computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Management"
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Node Communication TCP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Node Communication UDP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Overlay Network"
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "manager-sg"
  }
}

resource "aws_security_group" "worker" {
  name        = "worker-sg"
  description = "Security group for Docker Swarm Workers"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from my computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Management"
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Node Communication TCP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Node Communication UDP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Swarm Overlay Network"
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "worker-sg"
  }
}


#########################################
# Bastion Security Group
#########################################

# resource "aws_security_group" "bastion" {
#   name        = "bastion-sg"
#   description = "Bastion Host Security Group"
#   vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "SSH from your IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [var.allowed_ssh_cidr]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "bastion-sg"
#   }
# }