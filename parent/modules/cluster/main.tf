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
variable "volume_id" {
    type = string
}
variable "image_name" {
    type = string
}

data "openstack_images_image_v2" "test" {
  name = var.image_name
}

resource "openstack_compute_instance_v2" "test" {
  
  name = "${var.cluster_name}-test"
  image_name = data.openstack_images_image_v2.test.name
  flavor_name = "m3.medium"
  key_pair = "rocky_at_bastion"
  security_groups = ["default"]

  network {
    name = "bastion"
  }

  block_device {
      uuid = data.openstack_images_image_v2.test.id
      source_type  = "image"
      destination_type = "local"
      boot_index = 0
      delete_on_termination = true
  }

  block_device {
      destination_type = "volume"
      source_type  = "volume"
      boot_index = -1
      uuid = var.volume_id
  }

}
