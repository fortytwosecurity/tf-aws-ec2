module "iam_role" {
  source = "git::https://github.com/fortytwosecurity/tf-aws-ec2.git"

  iam_role_name = "${var.tags["environment"]}-${var.tags["role"]}"
}

