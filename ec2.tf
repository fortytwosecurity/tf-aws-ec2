#IAM ROLE
resource "aws_iam_instance_profile" "iam_profile" {
  name = "${var.tags["environment"]}-${var.tags["role"]}-${replace(uuid(), "-", "")}"
  role = module.iam_role.role_id

  lifecycle {
    ignore_changes = [name]
  }
}

#CLOUD INIT
data "template_file" "cloud_init" {
  template = file(
    "${path.root}/tf-aws-cloud-init/${var.cloud_init_template_prefix}_cloud_init_${var.cloud_init_distro}.tpl",
  )

  vars = {
    environment                    = var.tags["environment"]
    company                        = var.tags["company"]
    role                           = var.tags["role"]
    vaultpass                      = var.vaultpass
    memcached_endpoint             = var.memcached_endpoint
    redis_endpoint                 = var.redis_endpoint
    transdb_endpoint               = var.transdb_endpoint
    pandb_endpoint                 = var.pandb_endpoint
    cloud_init_automation_branch   = var.cloud_init_automation_branch
    cloud_init_automation_tag      = var.cloud_init_automation_tag
    cloud_init_automation_key_name = var.cloud_init_automation_key_name
  }
}

#LAUNCH CONFIG
resource "aws_launch_configuration" "launch_config" {
  name_prefix          = "${var.tags["environment"]}-${var.tags["role"]}-"
  image_id             = var.launch_config_image_id
  instance_type        = var.launch_config_instance_type
  iam_instance_profile = aws_iam_instance_profile.iam_profile.name
  key_name             = var.launch_config_key_name
  security_groups = concat(
    [aws_security_group.ec2_sg.id, aws_security_group.ec2_ssh.id],
    var.launch_config_security_groups,
  )
  user_data                   = data.template_file.cloud_init.rendered
  associate_public_ip_address = var.launch_config_associate_public_ip_address #tfsec:ignore:AWS012
  enable_monitoring           = var.launch_config_enable_monitoring

  lifecycle {
    create_before_destroy = true
    #    ignore_changes        = ["name", "iam_instance_profile"]
  }

  root_block_device {
    encrypted   = true
    volume_type = var.launch_config_root_block_device_volume_type
    volume_size = var.launch_config_root_block_device_volume_size
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${var.tags["environment"]}-${var.tags["role"]}"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.asg_ec2_subnet_ids
  termination_policies      = var.asg_termination_policies
  launch_configuration      = aws_launch_configuration.launch_config.name
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  protect_from_scale_in     = var.asg_protect_from_scale_in
  enabled_metrics           = var.asg_enabled_metrics
  target_group_arns         = var.asg_target_group_arns

  lifecycle {
    #    ignore_changes        = ["name", "aws_launch_configuration.launch_config"]
    create_before_destroy = true
  }

  tag {
    key = lookup(var.asg_tag_names, "tag_0", element(keys(var.tags), 0))
    value = lookup(
      var.tags,
      lookup(var.asg_tag_names, "tag_0", element(keys(var.tags), 0)),
      "",
    )
    propagate_at_launch = true
  }

  tag {
    key = lookup(var.asg_tag_names, "tag_1", element(keys(var.tags), 0))
    value = lookup(
      var.tags,
      lookup(var.asg_tag_names, "tag_1", element(keys(var.tags), 0)),
      "",
    )
    propagate_at_launch = true
  }

  tag {
    key = lookup(var.asg_tag_names, "tag_2", element(keys(var.tags), 0))
    value = lookup(
      var.tags,
      lookup(var.asg_tag_names, "tag_2", element(keys(var.tags), 0)),
      "",
    )
    propagate_at_launch = true
  }

  tag {
    key = lookup(var.asg_tag_names, "tag_3", element(keys(var.tags), 0))
    value = lookup(
      var.tags,
      lookup(var.asg_tag_names, "tag_3", element(keys(var.tags), 0)),
      "",
    )
    propagate_at_launch = true
  }

  tag {
    key = lookup(var.asg_tag_names, "tag_4", element(keys(var.tags), 0))
    value = lookup(
      var.tags,
      lookup(var.asg_tag_names, "tag_4", element(keys(var.tags), 0)),
      "",
    )
    propagate_at_launch = true
  }
}
