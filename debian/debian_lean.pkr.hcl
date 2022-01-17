variable "debian_iso_url" {
  type = string
  default = "https://deb.debian.org/debian/dists/stable/main/installer-amd64/current/images/netboot/mini.iso"
}

variable "debian_iso_checksum" {
  type = string
  default = "file:http://ftp.debian.org/debian/dists/stable/main/installer-amd64/current/images/SHA256SUMS"
}

locals {
  sudocmd = "echo 'packer' | sudo -S "
}

source "virtualbox-iso" "debian-virtualbox" {
  guest_os_type = "Debian_64"
  iso_url = "${var.debian_iso_url}"
  iso_checksum = "${var.debian_iso_checksum}"
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
    "<wait60s>http://{{ .HTTPIP }}:{{ .HTTPPort }}/debian-preseed.txt<enter>"
    # "<wait80s><enter><enter>" // for no root password
    # "<wait95s><enter>"  // this last enter is for "Unable is to skip the harmless CD error"
  ]
  ssh_timeout = "15m"
  shutdown_command = "${local.sudocmd} shutdown -P now"
}

build {

    // install sudo at least
  # provisioner "shell" {
  #   inline = [
  #     "su - packer <<!",
  #     "forsyde",
  #     "apt-get install sudo",
  #     "usermod -aG sudo packer",
  #     "echo 'packer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/packer",
  #     "chmod 440 /etc/sudoers.d/packer",
  #     "!"
  #   ]
  # }


  source "source.virtualbox-iso.debian-virtualbox" {
    disk_size = 30000
    vm_name = "forsyde-debian-lean"
    vboxmanage = [
      ["modifyvm", "{{ .Name }}", "--cpus", "1"],
      ["modifyvm", "{{ .Name }}", "--vram", "56"],
      ["modifyvm", "{{ .Name }}", "--memory", "1024"],
      ["usbfilter", "add", "0", "--target", "{{ .Name }}", "--name", "Altera Blaster [6001]", "--vendorid", "09fb", "--productid", "6001", "--manufacturer", "Altera", "--product", "USB-Blaster"],
      ["usbfilter", "add", "0", "--target", "{{ .Name }}", "--name", "Altera Blaster [6001]", "--vendorid", "09fb", "--productid", "6001", "--manufacturer", "Altera", "--product", "USB-Blaster"],
      ["usbfilter", "add", "0", "--target", "{{ .Name }}", "--name", "Altera Blaster [6002]", "--vendorid", "09fb", "--productid", "6002", "--manufacturer", "Altera", "--product", "USB-Blaster"],
      ["usbfilter", "add", "0", "--target", "{{ .Name }}", "--name", "Altera Blaster [6003]", "--vendorid", "09fb", "--productid", "6003", "--manufacturer", "Altera", "--product", "USB-Blaster"],
      ["usbfilter", "add", "0", "--target", "{{ .Name }}", "--name", "Altera Blaster [6010]", "--vendorid", "09fb", "--productid", "6010", "--manufacturer", "Altera", "--product", "USB-Blaster"],
      ["usbfilter", "add", "0", "--target", "{{ .Name }}", "--name", "Altera Blaster [6810]", "--vendorid", "09fb", "--productid", "6810", "--manufacturer", "Altera", "--product", "USB-Blaster"],
      ["modifyvm", "{{ .Name }}", "--usbohci", "on"],
      ["modifyvm", "{{ .Name }}", "--usbehci", "on"]
    ]
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

