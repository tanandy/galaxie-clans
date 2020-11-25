locals {
  project_name = "clan"

  clan_name              = "${terraform.workspace}_${local.project_name}"
  instance_name              = local.clan_name
  instance_type              = var.instance_type
  instance_image             = "debian_buster"
  instance_enable_ipv6       = true
  instance_enable_dynamic_ip = true

  ssh_public_key_name = local.instance_name
  ssh_public_key_file = var.ssh_public_key_file

  raw_inventory_name    = "${terraform.workspace}_raw"
  raw_inventory_group   = "raw"
  raw_ssh_user          = "root"

  ready_inventory_name  = terraform.workspace
  ready_inventory_group = local.project_name
  ready_ssh_user        = "caretaker"
}

resource scaleway_account_ssh_key admin {
  name       = local.ssh_public_key_name
  public_key = file(local.ssh_public_key_file)
}

resource scaleway_instance_security_group server {

  inbound_rule {
    action   = "accept"
    port     = 22
    protocol = "TCP"
    ip_range = "0.0.0.0/0"
  }

  outbound_rule {
    action = "accept"
  }
}

resource scaleway_instance_server server {

  name  = local.instance_name
  type  = local.instance_type
  image = local.instance_image

  enable_ipv6       = local.instance_enable_ipv6
  enable_dynamic_ip = local.instance_enable_dynamic_ip

  security_group_id = scaleway_instance_security_group.server.id
}