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
   default = "s-2vcpu-4gb"
}

variable DO_IMAGE {
   type = string
   default = "ubuntu-24-04-x64"
}

variable "private_key_file" {
   type = string
   default = "~/.ssh/fred_ed25519"
}

variable "public_key_file" {
   type = string
   default = "~/.ssh/fred_ed25519.pub"
}

variable "codeserver_password" {
   type = string
   sensitive = true
}