output "minionName" {
  description = "Salt minion Name"
  value       = ["${aws_instance.minion.*.tags.Name}"]
}

output "minionId" {
  description = "Salt minion ID"
  value       = "${aws_instance.minion.*.id}"
}

output "minionInstanceState" {
  description = "Salt minion Instance State"
  value       = "${aws_instance.minion.*.instance_state}"
}

output "minionPrivateDns" {
  description = "Salt minion Private DNS"
  value       = "${aws_instance.minion.*.private_dns}"
}

output "minionPrivateIp" {
  description = "Salt minion Private IP"
  value       = "${aws_instance.minion.*.private_ip}"
}

output "minionPublicDns" {
  description = "Salt minion Public DNS"
  value       = "${aws_instance.minion.*.public_dns}"
}

output "minionPublicIp" {
  description = "Salt minion Public IP"
  value       = "${aws_instance.minion.*.public_ip}"
}
