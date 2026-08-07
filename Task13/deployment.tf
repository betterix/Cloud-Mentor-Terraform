resource "aws_lb" "applb" {
  name               = "cmtr-ook9q7ho-lb"
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.sg_lb.id
  ]

  subnets = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_lb_listener" "applt" {
  load_balancer_arn = aws_lb.applb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue_tg.arn
        weight = var.blue_weight
      }

      target_group {
        arn    = aws_lb_target_group.green_tg.arn
        weight = var.green_weight
      }
    }
  }
}

resource "aws_lb_target_group" "blue_tg" {
  name     = "cmtr-ook9q7ho-blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id

  health_check {
    path = "/"
  }

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_lb_target_group" "green_tg" {
  name     = "cmtr-ook9q7ho-green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id

  health_check {
    path = "/"
  }

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_launch_template" "blue_template" {
  name          = "cmtr-ook9q7ho-blue-template"
  image_id      = "ami-02c25106ee38f6087"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    data.aws_security_group.sg_http.id,
    data.aws_security_group.sg_ssh.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/sh
    yum update -y
    yum install -y httpd

    systemctl start httpd
    systemctl enable httpd

    echo "<h1>Blue Environment</h1>" > /var/www/html/index.html
  EOF
  )

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_launch_template" "green_template" {
  name          = "cmtr-ook9q7ho-green-template"
  image_id      = "ami-02c25106ee38f6087"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    data.aws_security_group.sg_http.id,
    data.aws_security_group.sg_ssh.id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/sh
    yum update -y
    yum install -y httpd

    systemctl start httpd
    systemctl enable httpd

    echo "<h1>Green Environment</h1>" > /var/www/html/index.html
  EOF
  )

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_autoscaling_group" "blue_asg" {
  name = "cmtr-ook9q7ho-blue-asg"

  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  force_delete = true

  vpc_zone_identifier = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  launch_template {
    id      = aws_launch_template.blue_template.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.blue_tg.arn
  ]

  lifecycle {
    ignore_changes = [
      target_group_arns
    ]
  }
}

resource "aws_autoscaling_group" "green_asg" {
  name = "cmtr-ook9q7ho-green-asg"

  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  force_delete = true

  vpc_zone_identifier = [
    data.aws_subnet.public1.id,
    data.aws_subnet.public2.id
  ]

  launch_template {
    id      = aws_launch_template.green_template.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.green_tg.arn
  ]

  lifecycle {
    ignore_changes = [
      target_group_arns
    ]
  }
}
