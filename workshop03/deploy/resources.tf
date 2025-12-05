// Lookup snapshot
data "digitalocean_image" "codeserver_image" {
   name = "code-server-4.106.3-nginx-2025-12-05-0608"
}

data "digitalocean_ssh_key" "mykey" {
  name = var.ssh_key_name
}

resource "digitalocean_droplet" "codeserver" {
  name   = "codeserver-${var.codeserver_version}"
  image  = data.digitalocean_image.codeserver_image.id
  size   = var.DO_SIZE
  region = var.DO_REGION
  ssh_keys = [data.digitalocean_ssh_key.mykey.id]
}

resource "local_file" "inventory" {
  filename = "inventory.yaml"
  content = templatefile("${path.module}/inventory.yaml.tpl", {
    ansible_host = digitalocean_droplet.codeserver.ipv4_address
    ansible_user = "root"
    ansible_ssh_private_key_file = var.ssh_private_key_file
    codeserver_password = var.codeserver_password
    server_domain = "code-${digitalocean_droplet.codeserver.ipv4_address}.nip.io"
  })
}

output "nip_io_domain" {
  value = "code-${digitalocean_droplet.codeserver.ipv4_address}.nip.io"
  description = "nip.io domain for code-server"
}

output "droplet_ip" {
  value = digitalocean_droplet.codeserver.ipv4_address
  description = "IP address of the code-server droplet"
}

output "codeserver_url" {
  value = "http://code-${digitalocean_droplet.codeserver.ipv4_address}.nip.io"
  description = "URL to access code-server"
}