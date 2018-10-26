data "template_file" "install_salt_minion" {
  template = "${file("${path.module}/../../scripts/installSaltMinion.sh.tpl")}"
  count    = "${var.instance_count}"

  vars {
    minionId   = "${var.name}-${format("%02d", count.index+1)}"
    hostname   = "${var.name}-${format("%02d", count.index+1)}"
    masterNode = "${var.saltMaster}"
    minionEnv  = "${var.saltEnv}"
  }
}

resource "aws_instance" "minion" {
  count = "${var.instance_count}"

  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  user_data = "${element(data.template_file.install_salt_minion.*.rendered, count.index)}"

  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]

  associate_public_ip_address = "${var.associate_public_ip_address}"
  private_ip                  = "${var.private_ip}"

  tags = "${merge(var.tags, map("Name", var.instance_count > 1 ? format("%s-%d", var.name, count.index+1) : var.name))}"

  lifecycle {
    ignore_changes = ["private_ip", "root_block_device", "ebs_block_device"]
  }
}
