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

module "infra" {
    source = "../../parent/modules/infra"
    cluster_name = "child"
    volume_size = 1
}

output "cluster_name" {
    value = module.infra.cluster_name
}
output "volume_id" {
  value = module.infra.volume_id
}
