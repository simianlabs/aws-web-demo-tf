variable "awsRegion" {
  description = "AWS Default Region"
  default     = "eu-west-1"
}

# Network

variable "vpcID" {
  description = "ID of your AWS VPC"
}

variable "vpcCIDR" {
  description = "CIDR of your AWS VPC"
}

variable "subnetName" {
  description = "Name of private subnet"
  default     = "web_subnet"
}

variable "subnetCIDR" {
  description = "CIDR of private subnet"
  default     = "172.31.16.0/20"
}

variable "mapPublicIP" {
  description = "Change to true if dont want to make private but public subnet"
  default     = "false"
}

variable "public_subnet" {
  description = "ID of your default public ID for NATing internet access"
  default     = "subnet-c672e2a0"
}

# ECS2
variable "instanceCount" {
  description = "Number of instances created"
  default     = "3"
}

variable "ami" {
  description = "AMI ID used for instances. Cloud init is made for Ubuntu only. If you want to use different OS, you will need to modify template"
  default     = "ami-0eb66a0c3eb9f5183"
}

variable "keyName" {
  description = "Name of pre-generted server key"
  default     = "demo-salt-minions"
}

variable "instanceSize" {
  description = "AWS instance offering id"
  default     = "t2.micro"
}

# SaltStack
variable "saltEnv" {
  description = "Salt environment to which created minions will belong"
  default     = "base"
}

variable "saltMaster" {
  description = "IP or hostname of existing saltmaster"
  default     = "saltmaster"
}
