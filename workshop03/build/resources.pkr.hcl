source "digitalocean" "mydroplet" {
   api_token = var.DO_TOKEN
   image = "ubuntu-24-04-x64"
   size = "s-1vcpu-1gb"
   region = "sgp1"
   ssh_username = "root"
   snapshot_name = "code-server-${var.codeserver_version}-nginx-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
}

build {
   sources = [
      "source.digitalocean.mydroplet"
   ]

   provisioner "ansible" {
      playbook_file = "./playbook.yaml"
      user = "root"
      ansible_env_vars = [
         "ANSIBLE_HOST_KEY_CHECKING=False"
      ]
      extra_arguments = [
         "-e", "codeserver_version=${var.codeserver_version}"
      ]
   }
}