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

data "terraform_remote_state" "infra" {
    backend = "local"
    config = {
        path = "../infra/terraform.tfstate"
    }
}

module "cluster" {
    source = "../../parent/modules/cluster"

    image_name = "Rocky-8-GenericCloud-8.5-20211114.2.x86_64.qcow2"

    cluster_name = data.terraform_remote_state.infra.outputs.cluster_name
    volume_id = data.terraform_remote_state.infra.outputs.volume_id
    
}
