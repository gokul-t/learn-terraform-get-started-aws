
resource "aws_iam_role" "ec2_access_role" {
  name = "aws_iam_role.ec2_access_role.name"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam_readonly_attach" {
  role       = aws_iam_role.ec2_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_al2023"
  role = aws_iam_role.ec2_access_role.name
}
