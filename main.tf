terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "libvirt" {
  # Configuration options
  uri = "qemu:///system"
}

resource "null_resource" "qcow2" {
  provisioner "local-exec" {
    command = "curl -sSLo /opt/virtual/debian-11-generic-amd64.qcow2 https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2"
  }

  provisioner "local-exec" {
    command = "qemu-img resize /opt/virtual/debian-11-generic-amd64.qcow2 +10G"
  }

  provisioner "local-exec" {
    command = "qemu-img info /opt/virtual/debian-11-generic-amd64.qcow2"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm /opt/virtual/debian-11-generic-amd64.qcow2"
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}
