data "template_file" "default" {
  template = "${file("/opt/git/vspherelabautomation/terraform/vcsa/modules/vcsabuild/files/vcsatemplate.json")}"

  vars = {
    esxi_hostname = "${var.esxi_hostname}"
    esxi_username = "${var.esxi_username}"
    esxi_password = "${var.esxi_password}"
    esxi_network = "${var.esxi_network}"
    esxi_datastore = "${var.esxi_datastore}"
    vcsa_deploytype = "${var.vcsa_deploytype}"
    vcsa_name = "${var.vcsa_name}"
    vcsa_ipaddress = "${var.vcsa_ipaddress}"
    vcsa_dnsserver = "${var.vcsa_dnsserver}"
    vcsa_prefix = "${var.vcsa_prefix}"
    vcsa_gateway = "${var.vcsa_gateway}"
    vcsa_rootpassword = "${var.vcsa_rootpassword}"
    vcsa_ntpserver = "${var.vcsa_ntpserver}"
    sso_password = "${var.sso_password}"
    sso_domain = "${var.sso_domain}"
    sso_sitename = "${var.sso_sitename}"
    ceip = "${var.ceip}"
  }
}

resource "local_file" "rendered" {
    content     = "${data.template_file.default.rendered}"
    filename = "/opt/git/vspherelabautomation/terraform/vcsa/modules/vcsabuild/files/vcsatemplate_rendered.json"
}

resource "null_resource" "vc" {
  provisioner "local-exec" {
    command = "/opt/git/vspherelabautomation/terraform/vcsa/modules/vcsabuild/files/vcsa-cli-installer/lin64/vcsa-deploy install --accept-eula --acknowledge-ceip --no-ssl-certificate-verification /opt/git/vspherelabautomation/terraform/vcsa/modules/vcsabuild/files/vcsatemplate_rendered.json"
  }
}
