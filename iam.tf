module "iam_role" {
  source = "git::https://github.com/fortytwosecurity/tf-aws-iam-role-common.git"

  iam_role_name = "${var.tags["environment"]}-${var.tags["role"]}"
}

