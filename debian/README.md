# (Partial) Instructions for the ForSyDe Debian VM.

In the interest of outsourcing as much engineering work as possible, I've moved the
scripts for building the VM's to pure packer files. This means we can just use
whatever latest thing HashiCorp has for Packer and hopefully be happy about it.

## Virtual Box instructions

1. [Intall packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli).
2. [Install VBox as you would normally](https://www.virtualbox.org/wiki/Downloads) and don't forget the extention pack!
3. run `packer build <file>` where `file` is the description of the image you want.

When it's done, you should have a VM somewhere in the folder :).
