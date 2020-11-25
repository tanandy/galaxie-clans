output "raw_ssh_user" {
  value = local.raw_ssh_user
}

output "ipv4" {
  value = scaleway_instance_server.server.public_ip
}


output "ipv6" {
  value = scaleway_instance_server.server.ipv6_address
}
