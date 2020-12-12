resource "aws_security_group" "ec2_sg" {
  name        = "${var.tags["environment"]}-${var.tags["role"]}-ec2"
  vpc_id      = var.vpc_id
  description = "${var.tags["role"]} EC2 Instances Service SG"
  tags = merge(
    {
      "Name" = "${var.tags["environment"]}-${var.tags["role"]}-ec2"
    },
    var.tags,
  )
}

resource "aws_security_group" "ec2_ssh" {
  name        = "${var.tags["environment"]}-${var.tags["role"]}-ec2-ssh"
  vpc_id      = var.vpc_id
  description = "SSH to ${var.tags["role"]} EC2 Instances"
  tags = merge(
    {
      "Name" = "${var.tags["environment"]}-${var.tags["role"]}-ec2-ssh"
    },
    var.tags,
  )
}

# Outbound Rules
resource "aws_security_group_rule" "ec2_outbound_all" {
  count = var.enable_sg_outgoing_all ? 1 : 0

  type              = "egress"
  description       = "ec2_outbound_all"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_ssh_outbound_all" {
  count = var.enable_sg_outgoing_all ? 1 : 0

  type              = "egress"
  description       = "ec2_ssh_outbound_all"
  from_port         = 0
  to_port           = 65535
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
  security_group_id = aws_security_group.ec2_ssh.id
}

