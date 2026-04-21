terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    }
  }
}

provider "oci" {
  region = var.region
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "ubuntu" {
  compartment_id = var.compartment_id
  operating_system = "Canonical Ubuntu"
  operating_system_version = "22.04"
}

# --------------------
# Networking
# --------------------

resource "oci_core_virtual_network" "vcn" {
  compartment_id = var.compartment_id
  cidr_block     = "10.0.0.0/16"
  display_name   = "coolify-vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "public" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  cidr_block     = "10.0.1.0/24"
  route_table_id = oci_core_route_table.public.id
}

# --------------------
# NSGs
# --------------------

resource "oci_core_network_security_group" "control_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "coolify-control-nsg"
}


resource "oci_core_network_security_group_security_rule" "control_https" {
  network_security_group_id = oci_core_network_security_group.control_nsg.id
  direction = "INGRESS"
  protocol  = "6"
  source    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}


resource "oci_core_network_security_group_security_rule" "control_coolify_ui" {
  network_security_group_id = oci_core_network_security_group.control_nsg.id
  direction = "INGRESS"
  protocol  = "6" # TCP
  source    = "0.0.0.0/0"

  tcp_options {
    destination_port_range {
      min = 8000
      max = 8000
    }
  }
}


resource "oci_core_network_security_group" "worker_nsg" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "coolify-worker-nsg"
}

# --------------------
# Compute – Coolify Control
# --------------------

resource "oci_core_instance" "control" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape               = "VM.Standard.A1.Flex"
  display_name        = "coolify-control"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  create_vnic_details {
    subnet_id       = oci_core_subnet.public.id
    assign_public_ip = true
    nsg_ids         = [oci_core_network_security_group.control_nsg.id]
  }

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.ubuntu.images[0].id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = filebase64("cloud-init-control.yaml")
  }
}

# --------------------
# Compute – Worker
# --------------------

resource "oci_core_instance" "worker" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape               = "VM.Standard.A1.Flex"
  display_name        = "coolify-worker"

  shape_config {
    ocpus         = 3
    memory_in_gbs = 18
  }

  create_vnic_details {
    subnet_id       = oci_core_subnet.public.id
    assign_public_ip = true
    nsg_ids         = [oci_core_network_security_group.worker_nsg.id]
  }

  source_details {
    source_type = "image"
    source_id = data.oci_core_images.ubuntu.images[0].id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = filebase64("cloud-init-worker.yaml")
  }
}
