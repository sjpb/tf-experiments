terraform {
  required_version = ">= 0.14"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  cloud = "openstack"
}

variable "cluster_name" {
    type = string
}
variable "volume_size" {
    type = number # in GB
}

resource "openstack_blockstorage_volume_v3" "test" {
    name = "${var.cluster_name}-test"
    description = "State for control node"
    size = var.volume_size
}

output "volume_id" {
    value = openstack_blockstorage_volume_v3.test.id
}
output "cluster_name" {
    value = var.cluster_name
}
