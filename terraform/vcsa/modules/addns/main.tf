provider "dns" {
  update {
    server	= "$var.dns_server"
    gssapi {
      realm	= "$var.ad_realm"
      username	= "$var.ad_username"
      password	= "$var.ad_password"
    }
  }
}

