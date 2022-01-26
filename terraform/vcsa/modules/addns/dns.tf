resource "dns_a_record_set" "vcsa_hostname" {
  zone	= "$var.dns_zone"
  zone = "lab.local."
  name	= "$var.vcsa_hostname"
  addresses = ["$var.vcsa_ip"]
  ttl	= 3600
}

resource "dns_a_record_set" "esxi_hostname" {
  zone	= "$var.dns_zone"
  zone = "lab.local."
  name	= "$var.esxi_hostname"
  addresses = ["$var.esxi_ip"]
  ttl	= 3600
}

#resource "dns_ptr_record" "vcsa" {
#  zone = "31.168.192.in-addr.arpa."
#  name = "196"
#  ptr  = "vcsa.test.lab.local."
#  ttl 	= 3600
#}

#resource "dns_ptr_record" "vcsa" {
#  zone = "31.168.192.in-addr.arpa."
#  name = "196"
#  ptr  = "vcsa.lab.local."
#  ttl  = 3600
#}
