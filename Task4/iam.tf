resource "aws_iam_group" "group" {
  name = "cmtr-ook9q7ho-iam-group"
}

resource "aws_iam_policy" "policy" {
  name = "cmtr-ook9q7ho-iam-policy"

  policy = templatefile("${path.module}/policy.json", {
    bucket_name = "cmtr-ook9q7ho-bucket-1785916295"
  })

  tags = {
    Project = "cmtr-ook9q7ho"
  }
}

resource "aws_iam_role" "role" {
  name = "cmtr-ook9q7ho-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project = "cmtr-ook9q7ho"
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "profile" {
  name = "cmtr-ook9q7ho-iam-instance-profile"
  role = aws_iam_role.role.name

  tags = {
    Project = "cmtr-ook9q7ho"
  }
}
