provider "vsphere" {
  vsphere_server = "${var.vsphere_server}"
  user = "${var.vsphere_user}"
  password = "${var.vsphere_password}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_datastore" "host_datastore" {
  name          = "${var.host_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "iso_datastore" {
  name          = "${var.iso_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {}

data "vsphere_network" "mgmt_lan_0" {
  name          = "${var.network_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "mgmt_lan_1" {
  name          = "${var.network_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "mgmt_lan_2" {
  name          = "${var.network_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "mgmt_lan_3" {
  name          = "${var.network_name}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "esxi_host" {
  name             = "${var.esxi_host}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.host_datastore.id}"

  num_cpus   = 2
  memory     = 8192
  wait_for_guest_net_timeout = 0
  guest_id = "vmkernel65Guest"
  nested_hv_enabled =true
  
  network_interface {
    network_id     = "${data.vsphere_network.mgmt_lan_0.id}"
    adapter_type   = "vmxnet3"
  }
  network_interface {
    network_id     = "${data.vsphere_network.mgmt_lan_1.id}"
    adapter_type   = "vmxnet3"
  }
  network_interface {
    network_id     = "${data.vsphere_network.mgmt_lan_2.id}"
    adapter_type   = "vmxnet3"
  }
  network_interface {
    network_id     = "${data.vsphere_network.mgmt_lan_3.id}"
    adapter_type   = "vmxnet3"
  }

  disk {
    size             = 8
    label	     = "${var.esxi_host}${var.vmdk}"
    eagerly_scrub    = false
    thin_provisioned = true
  }

  cdrom {
    datastore_id = "${data.vsphere_datastore.iso_datastore.id}"
    path         = "${var.isopath}"
  }
}
