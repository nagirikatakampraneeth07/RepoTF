resource "aws_iam_user" "iam" {
  name = "adminaccess"
}

resource "aws_iam_policy" "iam" {
    name = "newpolicy"
    policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Action": [
				"ec2:RunInstances",
				"ec2:StartInstances",
				"ec2:StopInstances",
				"ec2:TerminateInstances",
				"ec2:DescribeInstances",
				"ec2:RebootInstances",
				"ec2:DescribeInstanceStatus",
				"ec2:DescribeInstances"
			],
			"Resource": "*"
		}
	]
})
  
}

resource "aws_iam_role" "iam" {
  name = "ec2access"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "iam" {
  name = "policytouser"
  users = [aws_iam_user.iam.name]
  policy_arn = aws_iam_policy.iam.arn
}

resource "aws_iam_policy_attachment" "new" {
  name = "awspolicyattachingtorole"
  roles = [aws_iam_role.iam.name]
  policy_arn = aws_iam_policy.iam.arn
}