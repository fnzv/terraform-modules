data "openstack_networking_network_v2" "network" {
  region = "${var.region}"
  name = "${var.network_name}"
}

data "openstack_networking_subnet_v2" "subnet" {
  network_id = "${data.openstack_networking_network_v2.network.id}"
  region = "${var.region}"
}

resource "openstack_networking_port_v2" "port_public" {
  name = "port_public"
  count = "${length(var.external_vips)}"
  network_id = "${data.openstack_networking_network_v2.network.id}"
  admin_state_up = "true"
  region = "${var.region}"
  fixed_ip = {
    ip_address = "${element(var.external_vips, count.index)}"
    subnet_id = "${data.openstack_networking_subnet_v2.subnet.id}"
  }
}

resource "openstack_networking_floatingip_v2" "port_public_floating_ip" {
  count = "${length(var.external_vips)}"
  pool = "PublicNetwork"
  port_id = "${element(openstack_networking_port_v2.port_public.*.id, count.index)}"
  region = "${var.region}"
}
