resource "aws_ssm_parameter" "swarm_manager_ip" {
  name  = "/docker-swarm/manager-ip"
  type  = "String"
  value = ""

  lifecycle {
    ignore_changes = [value]
  }

  tags = {
    Project = "docker-swarm"
  }
}

resource "aws_ssm_parameter" "swarm_worker_token" {
  name  = "/docker-swarm/worker-token"
  type  = "SecureString"
  value = "placeholder"

  lifecycle {
    ignore_changes = [value]
  }

  tags = {
    Project = "docker-swarm"
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "docker-swarm-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_policy" "ssm_parameter_policy" {
  name = "docker-swarm-ssm-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:PutParameter"
        ]
        Resource = [
          aws_ssm_parameter.swarm_manager_ip.arn,
          aws_ssm_parameter.swarm_worker_token.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = aws_iam_policy.ssm_parameter_policy.arn
}

#EC2 instances can't use an IAM Role directly—they need an Instance Profile.
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "docker-swarm-instance-profile"
  role = aws_iam_role.ec2_ssm_role.name
}

