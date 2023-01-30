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

  provisioner "file" {
    source = "provisioners/install-quartus-suite-13.sh"
    destination = "/tmp/install-quartus-suite-13.sh"
  }

  provisioner "shell" {
    inline = [
      "${local.sudocmd} mkdir -p /opt/provisioners",
      "${local.sudocmd} cp /tmp/install-quartus-suite-13.sh /opt/provisioners/install-quartus-suite-13.sh"
    ]
  }

  provisioner "file" {
    source = "provisioners/install-quartus-suite-19.sh"
    destination = "/tmp/install-quartus-suite-19.sh"
  }

  provisioner "shell" {
    inline = [
      "${local.sudocmd} mkdir -p /opt/provisioners",
      "${local.sudocmd} cp /tmp/install-quartus-suite-19.sh /opt/provisioners/install-quartus-suite-19.sh"
    ]
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/install-required.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/install-ada.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/install-lustre-tools.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/patch-drivers.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/patch-user.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/install-forsyde-tools.sh"
  }

}
