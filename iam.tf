module "iam_role" {
  source        = "../tf-aws-iam-role-common"
  iam_role_name = "${var.tags["environment"]}-${var.tags["role"]}"
}

