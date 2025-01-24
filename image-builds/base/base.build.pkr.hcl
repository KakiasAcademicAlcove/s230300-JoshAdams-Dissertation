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

variable "disable_breakpoint" {
    type    = string
    default = "false"
}

variable "disk_size" {
    type    = string
    default = "82432
}

variable "display" {
    type    = string
    default = "cocaoa,show-cursor=on"
}

variable "headless {
    type    = string
    default = "false"
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
  default = "sysuser"
}

variable "password" {
  type    = string
  default = "password"
}

variable "scripts_dir" {
  type    = string
  default = "scripts"
}

variable "vm_name" {
  type    = string
  default = "ubuntu.base.qcow2"
}