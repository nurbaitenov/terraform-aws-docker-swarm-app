output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet1" {
  value = aws_subnet.public1.id
}

output "public_subnet2" {
  value = aws_subnet.public2.id
}

output "manager_instance_id" {
  description = "Manager EC2 Instance ID"
  value       = aws_instance.manager.id
}

output "manager_public_ip" {
  description = "Manager Public IP"
  value       = aws_instance.manager.public_ip
}


output "launch_template_id" {
  description = "Worker Launch Template ID"
  value       = aws_launch_template.workers.id
}

output "launch_template_latest_version" {
  description = "Latest Launch Template Version"
  value       = aws_launch_template.workers.latest_version
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.asg.name
}

output "autoscaling_group_arn" {
  description = "Auto Scaling Group ARN"
  value       = aws_autoscaling_group.asg.arn
}