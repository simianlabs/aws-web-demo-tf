resource "aws_key_pair" "minion-key" {
  key_name   = "${var.keyName}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

module "ec2-instance" {
  source = "./modules/ec2minion"

  instance_count = "${var.instanceCount}"

  name                        = "${var.keyName}-${var.saltEnv}"
  ami                         = "${var.ami}"
  instance_type               = "${var.instanceSize}"
  subnet_id                   = "${aws_subnet.web_subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.internal_sg.id}"]
  associate_public_ip_address = false
  key_name                    = "${var.keyName}"

  saltMaster = "${var.saltMaster}"
  saltEnv    = "${var.saltEnv}"
}

resource "aws_elb" "web" {
  name = "web-elb"

  # subnets         = ["${aws_subnet.web_subnet.id}"]
  subnets         = ["${var.public_subnet}"]
  security_groups = ["${aws_security_group.elb_sg.id}"]
  instances       = ["${module.ec2-instance.minionId}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}
