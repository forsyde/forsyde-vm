variable "debian_iso_url" {
  type = string
  default = "https://deb.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/mini.iso"
}

variable "debian_iso_url_md5" {
  type = string
  default = "f1a1d3193bdaa26a217c4c8b61bbff9e"
}

locals {
  sudocmd = "echo 'packer' | sudo -S "
}

source "virtualbox-iso" "debian-virtualbox" {
  guest_os_type = "Debian_64"
  iso_url = "${var.debian_iso_url}"
  iso_checksum = "md5:${var.debian_iso_url_md5}"
  ssh_username = "packer"
  ssh_password = "packer"
  guest_additions_mode = "upload"
  guest_additions_path = "/tmp/VBoxGuestAdditions.iso"
  memory = 1024
  headless = true
  http_directory = "."
  boot_wait = "5s"
  boot_command = [
    "A<enter>", 
    "A<enter>", 
    "<wait50s>http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian-preseed.txt<enter>",
    "<wait5s><enter><enter>"
    // this last enter is for "Unable is to skip the harmless CD error"
    # "<wait95s><enter>"
  ]
  ssh_timeout = "15m"
  shutdown_command = "${local.sudocmd} shutdown -P now"
}

build {

  source "source.virtualbox-iso.debian-virtualbox" {
    disk_size = 30000
    vm_name = "forsyde-debian-lean"
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

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; ${local.sudocmd} {{ .Vars }} {{ .Path }};"
    script = "provisioners/install-xfce.sh"
  }

}

