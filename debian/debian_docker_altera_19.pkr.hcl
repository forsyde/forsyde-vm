variable "altera_19_download_url" {
  type = string
  default = "https://download.altera.com/akdlm/software/acdsinst/19.1std/670/ib_tar/Quartus-lite-19.1.0.670-linux.tar"
}

variable "altera_19_local_tarfile" {
  type = string
  default = ""
}

variable "altera_19_use_local" {
  type = bool
  default = false
}

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

  provisioner "shell" {
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

  provisioner "file" {
	only = ["var.altera_19_use_local"]
    source = "files/${var.altera_19_local_tarfile}"
    destination = "/tmp/${var.altera_19_local_tarfile}"
  }

  provisioner "shell" {
	only = ["var.altera_19_use_local"]
    environment_vars = ["QUARTUS_19_TAR_FILE=/tmp/${var.altera_19_local_tarfile}"]
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }}"
    script = "provisioners/install-quartus-tools-19.sh"
  }

  provisioner "shell" {
	except = ["var.altera_19_use_local"]
    environment_vars = ["QUARTUS_19_DOWNLOAD_URL=${var.altera_19_download_url}"]
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }}"
    script = "provisioners/install-quartus-tools-19.sh"
  }

}
