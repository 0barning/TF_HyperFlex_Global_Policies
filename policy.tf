data "intersight_organization_organization" "org" {
    name = var.organization
}

resource "intersight_hyperflex_vcenter_config_policy" "hyperflex_vcenter_config_policy1" {
  hostname    = "vcenter.workload.local"
  username    = "administrator@workload.local"
  password    = var.password
  data_center = "WLT"
  sso_url     = ""
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
  name = "${var.env}_HyperFlex_vCenter_Policy"
  description = "Created by Terraform"
}

resource "intersight_hyperflex_ucsm_config_policy" "hyperflex_ucsm_config_policy1" {
  name        = "${var.env}_HyperFlex_UCSM_Configuration_Policy"
  description = "Created by Terraform"
  kvm_ip_range {
    start_addr = "10.9.10.10"
    end_addr   = "10.9.10.100"
    gateway    = "10.9.10.1"
    netmask    = "255.255.255.0"
  }
  server_firmware_version = "4.1(2b)"
  organization {
    object_type = "organization.Organization"
    moid        = data.intersight_organization_organization.org.results[0].moid
  }
}
