locals {
  sudocmd = "echo 'packer' | sudo -S "
}

source "docker" "debian-docker" {
  image = "debian:bullseye"
  export_path = "forsyde-debian.tar"
  changes = [
    "USER forsyde",
    "ENTRYPOINT /bin/bash"
  ]
}

build {

  source "source.docker.debian-docker" {}

  provisioner "shell" {
    inline = [
      "apt-get update",
      "apt-get upgrade -y"
    ]
  }

  provisioner "shell" {
    script = "provisioners/install-required.sh"
  }

 "shell" {
    script = "provisioners/install-ada.sh"
  }

  provisioner "shell" {
    script = "provisioners/install-lustre-tools.sh"
  }

  provisioner "shell" {
    script = "provisioners/install-forsyde-tools.sh"
  }

  provisioner "shell" {
    script = "provisioners/patch-user.sh"
  }

  provisioner "shell" {
    script = "provisioners/patch-drivers.sh"
  }

}
