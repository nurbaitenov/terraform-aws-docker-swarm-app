#########################################
# Bastion Security Group
#########################################

resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "Bastion Host Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

#########################################
# Manager Security Group
#########################################

resource "aws_security_group" "manager" {
  name        = "manager-sg"
  description = "Docker Swarm Manager"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description = "Swarm Manager Port"
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
  }

  ingress {
    description = "Node Communication TCP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
  }

  ingress {
    description = "Node Communication UDP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
  }

  ingress {
    description = "Overlay Network"
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
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

#########################################
# Worker Security Group
#########################################

resource "aws_security_group" "worker" {
  name        = "worker-sg"
  description = "Docker Swarm Worker"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description     = "Swarm Manager Port"
    from_port       = 2377
    to_port         = 2377
    protocol        = "tcp"
    security_groups = [aws_security_group.manager.id]
  }

  ingress {
    description = "Node Communication TCP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
  }

  ingress {
    description = "Node Communication UDP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
  }

  ingress {
    description = "Overlay Network"
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    security_groups = [
      aws_security_group.manager.id,
      aws_security_group.worker.id
    ]
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

