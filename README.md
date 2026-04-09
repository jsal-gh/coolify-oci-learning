# Coolify on OCI – Learning Environment

This repository contains a **single learning environment** Terraform configuration
for deploying **Coolify on Oracle Cloud Infrastructure (OCI)**.

The design is intentionally minimal and optimised for:
- OCI Always Free tier usage
- Learning and experimentation
- GUI-based deployment via OCI Resource Manager
- Minimal operational complexity

---

## Architecture Summary

- Single OCI region
- Single VCN and public subnet
- Two Ampere A1 Flex instances:
  - Coolify control plane (Traefik + TLS)
  - Worker node (application containers)
- No OCI Load Balancer
- Traefik managed by Coolify
- Let’s Encrypt certificates managed by Coolify
- Network Security Groups (NSGs)
- OCI Block Volumes with daily backups

---

## ☁️ Deploying with OCI Resource Manager (Recommended)

This repository is designed to be deployed **entirely via the OCI Console**.

### Deployment Steps

1. OCI Console → **Developer Services → Resource Manager**
2. Click **Create Stack**
3. Terraform configuration source → **GitHub**
4. Authenticate to GitHub (read-only access is sufficient)
5. Select this repository and the `main` branch
6. Enter required variables:
   - `compartment_id`
   - `region`
   - `ssh_public_key`
   - `admin_cidr`
7. Click **Create Stack**
8. Run **Plan**
9. If the plan looks correct, run **Apply**

---

## 🚀 After Deployment

- Note the **public IP** of the Coolify control instance
- Access Coolify at: http://<control-node-public-ip>:8000</control-node-public-ip>

- Complete the first-run wizard
- Register the worker node from the Coolify UI

---

## 🔧 Automation Details

- Docker is installed automatically via cloud-init
- Coolify is auto-installed on the control node
- Workers are Docker-only and registered manually
- Block volumes are backed up daily using OCI policies

---

## ✅ Intended Use

This repository is intended for:
- Learning OCI fundamentals
- Learning Coolify
- Experimenting with PaaS-style workflows
- Clean rebuild and teardown

It is intentionally *not* over-engineered.

---

## 🔄 Destroying and Rebuilding the Environment

This environment is intentionally designed to be **disposable**.

### Destroying via OCI Resource Manager

1. OCI Console → **Developer Services → Resource Manager**
2. Open the stack created from this repository
3. Click **Destroy**
4. Confirm the destruction

This will remove:
- Compute instances
- Block volumes
- Networking resources

---

### Rebuilding

To rebuild from scratch:

1. Open the same stack
2. Click **Apply**
3. Wait for deployment to complete

Because all infrastructure is defined in Terraform and bootstrapped with cloud‑init:
- No manual reconfiguration is required
- Coolify installs automatically
- The environment is fully reproducible

---

## 🏷️ Resource Tagging and Cost Visibility

All resources created by this stack are intended to share a common tagging strategy.

Recommended tags:

| Key | Value |
|----|------|
| Environment | learning |
| Project | coolify |
| Owner | <your-name> |
| ManagedBy | terraform |
| Purpose | learning |

### Benefits
- Easier cost analysis
- Cleaner resource inventory
- Better habits for production environments

Tagging can be enforced later directly in Terraform once the learning objectives are met.
