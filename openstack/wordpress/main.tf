# Create instance
module "wordpress" {
  source = "github.com/entercloudsuite/terraform-modules//openstack/instance?ref=2.7"
  name = "${var.name}"
  image = "ecs-docker 1.0.1"
  quantity = "${var.quantity}"
  flavor = "${var.flavor}"
  network_name = "${var.network_name}"
  sec_group = "${var.sec_group}"
  keypair = "${var.keypair}"
  tags = {
    "server_group" = "WEB"
  }
  userdata = "${data.template_file.cloud-config.*.rendered}"
  discovery = "${var.discovery}"
  external = "${var.external}"
  region = "${var.region}"
}

data "template_file" "cloud-config" {
  template = "${file("${path.module}/cloud-config.yml")}"
  vars {
    name = "${var.name}"
    db_password = "${var.db_password}"
    db_user = "${var.db_user}"
    db_host = "${var.db_host}"
    es_host = "${var.es_host}"
    consul = "${var.consul}"
    consul_port = "${var.consul_port}"
    consul_datacenter = "${var.consul_datacenter}"
    consul_encrypt = "${var.consul_encrypt}"
  }
}
