// The name of the autoscale group
output "autoscaling_group_name" {
  value = aws_autoscaling_group.autoscaling_group.name
}

// The ID of the EC2 Security Group
output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

// The ID of the EC2 SSH Security Group
output "ec2_ssh_sg_id" {
  value = aws_security_group.ec2_ssh.id
}

// The ID of the IAM role
output "iam_role_id" {
  value = module.iam_role.role_id
}

// The Amazon Resource Name (ARN) of the IAM role
output "iam_role_arn" {
  value = module.iam_role.role_arn
}

// The name of the autoscaling group
output "asg_name" {
  value = aws_autoscaling_group.autoscaling_group.name
}

// The arn of the autoscale group
output "asg_arn" {
  value = aws_autoscaling_group.autoscaling_group.arn
}

