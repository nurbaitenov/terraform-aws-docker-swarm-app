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
  name   = "manager-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
}

#########################################
# Worker Security Group
#########################################

resource "aws_security_group" "worker" {
  name   = "worker-sg"
  vpc_id = aws_vpc.main.id
}


resource "aws_security_group_rule" "worker_to_manager_2377" {
  type      = "ingress"
  from_port = 2377
  to_port   = 2377
  protocol  = "tcp"

  security_group_id        = aws_security_group.manager.id
  source_security_group_id = aws_security_group.worker.id
}
