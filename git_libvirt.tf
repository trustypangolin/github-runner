resource "libvirt_volume" "debian-qcow2-git" {
  name       = "debian11-git-${count.index}.qcow2"
  depends_on = [null_resource.qcow2]
  count      = var.git_runners
  pool       = "default" # List storage pools using virsh pool-list
  source     = "/opt/virtual/debian-11-generic-amd64.qcow2"
  format     = "qcow2"
}

resource "libvirt_cloudinit_disk" "commoninit_git" {
  name           = "commoninit_git.iso"
  user_data      = data.template_file.git_user_data.rendered
  network_config = data.template_file.network_config.rendered
}

data "template_file" "git_user_data" {
  template = templatefile("${path.module}/git_cloud_init.cfg",
    { config = {
      githubtoken  = var.githubtoken,
      gitlabtoken  = var.gitlabtoken,
      gitorg       = var.gitorg,
      gitproject   = var.gitproject,
      lang         = var.lang,
      linuxuser    = var.linuxuser,
      publicssh    = var.publicssh,
      release      = var.release
      timezone     = var.timezone,
      OAUTH_ID     = var.oid
      OAUTH_SECRET = var.osecret
      }
    }
  )
}

resource "libvirt_domain" "domain-debian-git" {
  name      = "debian-git-${count.index}"
  count     = var.git_runners
  memory    = "1024"
  vcpu      = 1
  cmdline   = []
  cloudinit = libvirt_cloudinit_disk.commoninit_git.id

  network_interface {
    macvtap = "eth0"
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.debian-qcow2-git[count.index].id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
