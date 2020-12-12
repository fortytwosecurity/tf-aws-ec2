# Cloud Init
variable "cloud_init_distro" {
  description = "The OS distribution name"
  default     = "amazon_linux"
}

variable "cloud_init_template_prefix" {
  description = "The cloud init template prefix used to build the name of the template"
  default     = "common"
}

variable "cloud_init_automation_branch" {
  description = "checkout this branch of the Automation repo in the instance' cloud-init before running Ansible"
  default     = "master"
}

variable "cloud_init_automation_tag" {
  description = "checkout this tag of the Automation repo in the instance' cloud-init before running Ansible"
  default     = "master"
}

variable "cloud_init_automation_key_name" {
  description = "Use this key in cloud-inits to connect to Github"
}

# Launch Configuration
variable "launch_config_image_id" {
  description = "The EC2 image ID to launch"
}

variable "launch_config_instance_type" {
  description = "The size of instance to launch"
  default     = "t2.micro"
}

variable "launch_config_key_name" {
  description = "The key name that should be used for the instance"
}

variable "launch_config_associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  default     = false
}

variable "launch_config_enable_monitoring" {
  description = "Enables/disables detailed monitoring"
  default     = false
}

variable "launch_config_root_block_device_volume_type" {
  description = "The type of volume. Can be 'standard', 'gp2', or 'io1'"
  default     = "gp2"
}

variable "launch_config_root_block_device_volume_size" {
  description = "The size of the volume in gigabytes"
  default     = 8
}

variable "launch_config_security_groups" {
  description = "A list of associated security group IDS to be appended to the ones created by this module (only 2 SG allowed)"
  default     = []
}

# Auto Scaling Group
variable "asg_min_size" {
  description = "The minimum size of the auto scale group"
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum size of the auto scale group"
  default     = 1
}

variable "asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  default     = 1
}

variable "asg_ec2_subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "asg_termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
  default     = ["Default"]
}

variable "asg_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "asg_health_check_type" {
  description = "Controls how health checking is done. Should be allways 'EC2' as this module does not have ELB"
  default     = "EC2"
}

variable "asg_tag_names" {
  description = "A mapping of tag names to assign to the ASG resource. Should match the naming of the keys in tags variable"
  type        = map(string)
}

variable "asg_target_group_arns" {
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  type        = list(string)
  default     = []
}

variable "asg_protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events."
  default     = false
}

variable "asg_enabled_metrics" {
  description = "A list of ASG metrics to collect."
  default     = []
}

# Common variables
variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}

variable "vaultpass" {
  description = "The password to decrypt the Ansible vault"
  default     = "password"
}

variable "memcached_endpoint" {
  description = "The memcached cluster endpoint"
  default     = "memcached_endpoint"
}

variable "redis_endpoint" {
  description = "The redis cluster endpoint"
  default     = "redis_endpoint"
}

variable "transdb_endpoint" {
  description = "The transdb rds endpoint"
  default     = "transdb_endpoint"
}

variable "pandb_endpoint" {
  description = "The pandb rds endpoint"
  default     = "pandb_endpoint"
}

variable "enable_sg_outgoing_all" {
  description = "Allow all outgoing traffic"
  default     = true
}

variable "aws_region" {
  description = "AWS region name"
  default     = "eu-central-1"
}
