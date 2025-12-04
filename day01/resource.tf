resource "docker_network" "bgg-net" {
    name    = "bgg-net"
}

resource "docker_volume" "data-vol" {
    name = "data-vol"
}

resource "docker_image" "bgg-database" {
    name         = "chukmunnlee/bgg-database:nov-2025"
}

resource "docker_container" "bgg-database" {
    name    = "bgg-database"
    image   = docker_image.bgg-database.image_id

    volumes {
        # Referencing the volume name created by the docker_volume resource
        volume_name    = docker_volume.data-vol.name
        container_path = "/var/lib/mysql"
    }

    ports {
        internal = 3306
    }

    networks_advanced {
        name = docker_network.bgg-net.name
    }
}

resource "docker_image" "bgg-app" {
    name = "chukmunnlee/bgg-app:nov-2025"
}

resource "docker_container" "bgg-app" {
    count = 3
    name  = "bgg-app-${count.index}"
    image = docker_image.bgg-app.image_id
    env = [
        "BGG_DB_USER=root",
        "BGG_DB_PASSWORD=${var.db_passsword}",
        "BGG_DB_HOST=${docker_container.bgg-database.name}"
    ]

    networks_advanced {
        name = docker_network.bgg-net.name
    }

    ports {
        internal = 5000
        external = 8080 + count.index
    }

}

resource "local_file" "nginx_conf" {
    filename = "ngix.conf"
    file_permission = "0444"
    content = templatefile("nginx.conf.tftpl", {
        bggapp_name = docker_container.bgg-app[*].name
        bggapp_port = 5000
    })
  
}

resource "digitalocean_droplet" "bgg_droplet" {
  name   = "bgg-droplet"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-24-04-x64"
  region = "sgp1"
  tags = ["bgg", "application"]
  ssh_keys = ["e6:3c:61:17:e4:c5:5d:3b:4c:49:25:46:75:25:2c:1e"]
  connection {
    host        = self.ipv4_address
    user        = "root"
    private_key = file("~/.ssh/fred_ed25519")
  }
  provisioner "file" {
    source      = "workshop01_nginx_assets.zip" 
    destination = "/tmp/workshop01_nginx_assets.zip"
  }
  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt install nginx -y",
      "systemctl daemon-reload",
      "systemctl enable nginx",
      "systemctl start nginx",
      "apt install unzip -y",
      "unzip /tmp/workshop01_nginx_assets.zip -d /var/www/html",
      "sed -i 's/Droplet IP address here/${self.ipv4_address}/g' /var/www/html/index.html" 
    ]
  }
}















