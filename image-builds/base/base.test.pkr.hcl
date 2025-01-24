packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
    inspec = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/inspec"
    }
  }
}

variable "accelerator" {
  type    = string
  default = "hvf"
}

variable "base_image" {
  type    = string
  default = ""
}
