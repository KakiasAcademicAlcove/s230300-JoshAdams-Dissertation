packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}

variable "accelerator" {
    type    = string
    default = "hvf"
}

variable "base_image" {
    type    = string
    default = "./artifacts/ubuntu-22.04.5-live-server-amd64.qcow2"
}

variable "cpu" {
    type    = string
    default = "max"
}

variable "smp" {
    type    = string
    default = "8"
}

variable "disable_breakpoint" {
    type    = string
    default = "false"
}

variable "disk_size" {
    type    = string
    default = "82432"
}

variable "display" {
    type    = string
    default = "cocaoa,show-cursor=on"
}

variable "headless {
    type    = string
    default = "true"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "output_directory" {
  type    = string
  default = "./builds"
}

variable "user" {
  type    = string
  default = "sys_user"
}

variable "password" {
  type    = string
  default = "password"
}

variable "scripts_dir" {
  type    = string
  default = "./scripts"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-base.qcow2"
}

source "qemu" "base" {
    accelerator                 = "${var.accelerator}"
    boot_command                = ["<enter><wait>"]
    boot_wait                   = "2s"
    cpus                        = "${var.smp}"
    disk_compression            = true
    disk_image                  = true
    disk_interface              = "ide"
    disk_size                   = "${var.disk_size}"
    format                      = "qcow2"
    headless                    = "${var.headless}"
    host_port_max               = 2229
    host_port_min               = 2222
    http_directory              = "./"
    http_port_max               = 10089
    http_port_min               = 10082
    iso_checksum                = "none"
    iso_url                     = "${var.base_image}"
    memory                      = "${var.memory}"
    net_device                  = "virtio-net"
    output_directory            = "./build-${local.timestamp}"
    qemuargs                      = [["-cpu", "${var.cpu}"], ["-display", "${var.display}"], ["-m", "${var.memory}"], ["-serial", "stdio"]]
    shutdown_command              = "sudo shutdown -P now"
    ssh_clear_authorized_keys     = true
    ssh_password                  = "${var.password}"
    ssh_port                      = 22
    ssh_timeout                   = "15m"
    ssh_username                  = "${var.user}"
    vm_name                       = "${var.vm_name}"
}

build {
    source =["source.qemu.base"]

    provisioner "shell" {
        inline          = ["sudo mkdir -p /apps/opt", "sudo chmod -R 777 /apps", "sudo systemctl stop crond denyhosts docker logscan netdata nginx ntpd oswatcher rsyslog || echo 'Never mind ...'"]
        remote_folder   = "/home/${var.user}"
    }

    provisioner "file" {
        destination = "/apps/opt"
        source      = "./uploads"
    }

    provisioner "shell" {
        execute_command   = "sudo -E bash '{{ .Path }}'"
        expect_disconnect = true
        remote_folder     = "/home/${var.user}"
        scripts           = ["${var.scripts_dir}/<insert-script>"]
    }
    provisioner "file" {
        destination = "log-files/build/image_logs.tar.gz"
        direction   = "download"
        source     = "/image_logs.tar.gz"
    }
    provisioner "breakpoint" {
        disable = "${var.disable_breakpoint}"
        note    = "Build held to allow for SSH access by user"
    }
    provisioner "shell" {
        inline        = ["sudo rm -f /etc/ssh/ssh_host_*"]
        remote_folder = "/home/${var.user}"
    }
    provisioner "shell" {
        inline        = ["echo 'ALL DONE....SHUT ME DOWN'", "exit 0"]
        remote_folder = "/home/${var.user}"
    }

    post-processor "checksum" {
        checksum_types = ["md5", "sha1", "sha256"]
        output         = "./build-${local.build_time}/packer_{{ .BuildName }}_{{ .ChecksumType }}.checksum"
    }
}