variable "name" {
  description = "Name to be used on all resources as prefix"
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "ami" {
  description = "ID of AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to start"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = ""
}

variable "slackToken" {
  description = "TOKEN from slack webhook url: XXXXXX/XXXXXXX/XXXXXXXXXXXXXXX"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "saltMaster" {
  description = "Salt master adress"
  default     = "localhost"
}

variable "saltEnv" {
  description = "Salt enviroment to which minions belong"
  default     = "base"
}
