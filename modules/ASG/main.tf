terraform {
  required_version = "0.13.6"
}

provider "aws" {
  region = "us-west-2"
  version = "~> 2.0"
} 

resource "aws_launch_configuration" "asLaunchConfig" {
  image_id        = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.AutoScalingSecurityGroup.id]

  user_data       = data.template_file.user_data.rendered

    lifecycle {
        create_before_destroy = true
    }
}

data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
}

resource "aws_autoscaling_group" "AutoScalingGroup" {
  launch_configuration = aws_launch_configuration.asLaunchConfig.name
  vpc_zone_identifier  = ["subnet-05ce737c"]

  desired_capacity  = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = "Terraform-AutoScalingGroup"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "AutoScalingSecurityGroup" {
  name = "AutoScalingSecurityGroup"
  vpc_id =  "vpc-faf77d9d"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
