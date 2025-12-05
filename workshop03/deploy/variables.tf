variable DO_TOKEN {
   type = string 
   sensitive = true
}

variable DO_REGION {
   type = string
   default = "sgp1"
}

variable "DO_SIZE" {
   type = string 
   default = "s-1vcpu-1gb"
}

variable DO_IMAGE {
   type = string
   default = "ubuntu-24-04-x64"
}

variable "codeserver_version" {
   type = string
   description = "Version of code-server to use"
}

variable "codeserver_password" {
   type = string
   sensitive = true
   description = "Password for code-server"
}

variable "ssh_public_key_file" {
   type = string
   default = "~/.ssh/id_rsa.pub"
   description = "Path to SSH public key"
}

variable "ssh_private_key_file" {
   type = string
   default = "~/.ssh/id_rsa"
   description = "Path to SSH private key"
}

variable "ssh_key_name" {
   type = string
   description = "Name of existing SSH key in DigitalOcean"
   default = "codeserver-key"
}