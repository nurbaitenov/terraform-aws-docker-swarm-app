resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.subnets
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.workers.id
    version = "$Latest"
  }

  depends_on = [
    aws_instance.manager,
    aws_launch_template.workers
  ]

  health_check_type         = "EC2"
  health_check_grace_period = 300
}

# Create a new load balancer
# resource "aws_elb" "bar" {
#   name               = "foobar-terraform-elb"
#   subnets = var.subnets
#   listener {
#     instance_port     = 8000
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "TCP:80"
#     interval            = 30
#   }

#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400

#   tags = {
#     Name = "foobar-terraform-elb"
#   }
# }

# resource "aws_autoscaling_attachment" "example" {
#   autoscaling_group_name = aws_autoscaling_group.bar.id
#   elb                    = aws_elb.bar.id
# }
