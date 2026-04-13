# Post-Deploy Runbook
**Coolify on OCI (Ubuntu 22.04 Baseline)**

---

## 1. Purpose & Scope

### Purpose
This runbook documents the **post-deploy operational steps** required after Terraform has provisioned the infrastructure baseline for a self-hosted Coolify platform on Oracle Cloud Infrastructure (OCI).

### Scope
This runbook covers:
- Day‑1 validation
- Coolify installation
- Worker registration
- Initial platform validation
- Basic hardening

This runbook **does not** cover:
- Terraform provisioning
- Application lifecycle details
- Advanced HA or DR scenarios

---

## 2. Assumptions & Preconditions

### Infrastructure (Day‑0)
- Infrastructure provisioned via Terraform
- Ubuntu 22.04 LTS on all nodes
- Network Security Groups applied
- Public IP on control node
- SSH access available

### Software Baseline (Required)
On **control and worker nodes**:
- Docker Engine installed and running
- Docker Compose **v2 plugin** installed
- Outbound internet access available

---

## 3. Roles & Responsibilities

| Role | Responsibility |
|-----|---------------|
| Terraform / Platform Engineer | Infrastructure provisioning |
| Platform Operator | Coolify installation & configuration |
| Application Teams | App deployment via Coolify |

---

## 4. Day‑1 Baseline Verification

### 4.1 OS & Connectivity Checks

Run on the **control node**:

```bash
hostname
uptime
``
