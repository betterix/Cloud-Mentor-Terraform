data "aws_security_group" "ec2_sg" {
  name = "cmtr-ook9q7ho-ec2_sg"
}

data "aws_security_group" "http_sg" {
  name = "cmtr-ook9q7ho-http_sg"
}

data "aws_security_group" "alb_sg" {
  name = "cmtr-ook9q7ho-sglb"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-ook9q7ho-vpc"]
  }
}

data "aws_subnet" "public_a" {
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }

  vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet" "public_b" {
  filter {
    name   = "cidr-block"
    values = ["10.0.3.0/24"]
  }

  vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet" "private_a" {
  filter {
    name   = "cidr-block"
    values = ["10.0.2.0/24"]
  }

  vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet" "private_b" {
  filter {
    name   = "cidr-block"
    values = ["10.0.4.0/24"]
  }

  vpc_id = data.aws_vpc.vpc.id
}


resource "aws_launch_template" "template" {
  name          = "cmtr-ook9q7ho-template"
  image_id      = "ami-02c25106ee38f6087"
  instance_type = "t3.micro"

  network_interfaces {
    delete_on_termination = true
    security_groups = [
      data.aws_security_group.ec2_sg.id,
      data.aws_security_group.http_sg.id
    ]
  }

  key_name = "cmtr-ook9q7ho-keypair"

  iam_instance_profile {
    name = "cmtr-ook9q7ho-instance_profile"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOF
    #!/bin/sh

    yum update -y
    yum install httpd jq -y

    systemctl start httpd
    systemctl enable httpd

    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
    PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

    echo "This message was generated on instance $${INSTANCE_ID} with the following IP: $${PRIVATE_IP}" > /var/www/html/index.html
  EOF
  )

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name = "cmtr-ook9q7ho-asg"

  desired_capacity = 2
  min_size         = 1
  max_size         = 2

  vpc_zone_identifier = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_b.id
  ]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}

resource "aws_lb" "applb" {
  name               = "cmtr-ook9q7ho-loadbalancer"
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.alb_sg.id
  ]

  subnets = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_b.id
  ]

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_lb_target_group" "apptg" {
  name     = "cmtr-ook9q7ho-targetgroup"
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

resource "aws_lb_listener" "applt" {
  load_balancer_arn = aws_lb.applb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.apptg.arn
  }

  tags = {
    Terraform = true,
    Project   = var.project_id
  }
}

resource "aws_autoscaling_attachment" "appasg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  lb_target_group_arn    = aws_lb_target_group.apptg.arn
}
