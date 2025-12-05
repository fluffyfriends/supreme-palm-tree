variable DO_TOKEN {
   type = string 
   sensitive = true
}

variable "codeserver_version" {
   type = string
   default = "4.106.3"
   description = "Version of code-server to install"
}