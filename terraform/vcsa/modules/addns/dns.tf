resource "dns_a_record_set" "vcsa_hostname" {
  zone = "lab.local."
  name	= "$var.vcsa_hostname"
  addresses = ["$var.vcsa_ip"]
  ttl	= 3600
}

resource "dns_a_record_set" "esxi_hostname" {
  zone = "lab.local."
  name	= "$var.esxi_hostname"
  addresses = ["$var.esxi_ip"]
  ttl	= 3600
}

