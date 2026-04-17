# Day‑0 Terraform Build Guide
**OCI + Coolify Baseline**

## Purpose
This document defines what Terraform is responsible for provisioning and what it intentionally does not manage.

Terraform establishes a **known‑good infrastructure baseline** only.

## Guaranteed Outcomes (If Terraform Succeeds)
After a successful Terraform apply:

- OCI VCN and subnet exist
- Internet access is available
- Control and worker compute instances exist
- Ubuntu 22.04 LTS is installed
- Docker Engine is installed and running
- Docker Compose v2 plugin is installed
- NSGs allow required ports

Terraform does **not** install Coolify or configure the platform.

## Inputs
- OCI region
- Compartment OCID
- CIDR ranges
- SSH public key (for initial access)
- Instance shapes

## What Terraform Provisions

### Networking
- VCN
- Public subnet
- Internet Gateway
- Route table
- Network Security Groups

### Compute
- Control node
- Worker node
- Ubuntu 22.04 image

### Security Groups

**Control node NSG**
- TCP 22 (restricted CIDR)
- TCP 80 (temporary – ACME)
- TCP 443 (HTTPS)
- TCP 8000 (temporary – bootstrap)

**Worker node NSG**
- TCP 22 (from control node only)

### OS Bootstrap
- Docker Engine
- Docker Compose v2 plugin
- Docker enabled and started

## Explicit Non‑Goals
Terraform intentionally does NOT:
- Install Coolify
- Configure TLS
- Register workers
- Configure email
- Deploy applications
- Manage SSH trust between nodes

These are operational concerns.

## Assumptions
- Outbound internet access is available
- DNS resolution works
- Operators will complete Day‑1 steps

## Rationale
Keeping Terraform focused avoids:
- Fragile applies
- State drift
- Coupling infrastructure with platform state

## Summary
Terraform provisions **substrate**, not **platform behaviour**.  
All platform operations are deferred to Day‑1.
