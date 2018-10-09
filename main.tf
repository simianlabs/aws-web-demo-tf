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
