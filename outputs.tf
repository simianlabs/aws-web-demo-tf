output "instance_id" {
  value = ["${module.ec2-instance.minionName}"]
}

output "instance_ips" {
  value = ["${module.ec2-instance.minionPrivateIp}"]
}

output "elb_dns" {
  value = "${aws_elb.web.dns_name}"
}
