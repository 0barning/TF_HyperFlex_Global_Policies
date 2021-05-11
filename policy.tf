data "intersight_organization_organization" "org" {
    name = var.organization
}

resource "intersight_hyperflex_vcenter_config_policy" "hyperflex_vcenter_config_policy1" {
  hostname    = "vcenter.${var.dns_domain_suffix}"
  username    = "administrator@${var.dns_domain_suffix}"
  password    = var.password
  data_center = var.env
  sso_url     = ""
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "${var.env}_HyperFlex_vCenter_Policy"
  description = "Created by Terraform"
}

resource "intersight_hyperflex_local_credential_policy" "hyperflex_local_credential_policy1" {
  hxdp_root_pwd               = var.password
  hypervisor_admin            = "root"
  hypervisor_admin_pwd        = var.password
  factory_hypervisor_password = false
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "${var.env}_Hyperflex_local_credential_policy"
  description = "Created by Terraform"
}

resource "intersight_hyperflex_sys_config_policy" "hyperflex_sys_config_policy1" {
  dns_servers     = ["${var.subnet_str}.3"]
  ntp_servers     = ["${var.subnet_str}.3"]
  timezone        = "Europe/Amsterdam"
  dns_domain_name = var.dns_domain_suffix
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "${var.env}_HyperFlex_System_Config_Policy"
  description = "Created by Terraform"
}

resource "intersight_hyperflex_cluster_storage_policy" "hyperflex_cluster_storage_policy1" {
  disk_partition_cleanup = true
  vdi_optimization       = true
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "${var.env}_HyperFlex_Storage_Cluster_Policy"
  description = "Created by Terraform"
}

