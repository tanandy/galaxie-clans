output "ansible_ssh_config" {
  value = <<-EOF
Host ${local.raw_inventory_name}
  Hostname ${scaleway_instance_server.server.public_ip}
  User ${local.raw_ssh_user}
  StrictHostKeyChecking no
  IdentityFile ./keys/${terraform.workspace}.key
  IdentitiesOnly yes

Host ${local.ready_inventory_name}
  Hostname ${scaleway_instance_server.server.public_ip}
  User ${local.ready_ssh_user}
  StrictHostKeyChecking no
  IdentityFile ./keys/${terraform.workspace}.key
  IdentitiesOnly yes
EOF
}

output "ansible_inventory" {
  value = <<-EOF
[${local.clan_name}]
${local.ready_inventory_name}
${local.raw_inventory_name}
EOF
}

output "ipv4" {
  value = scaleway_instance_server.server.public_ip
}

output "ipv6" {
  value = scaleway_instance_server.server.ipv6_address
}
