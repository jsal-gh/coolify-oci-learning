# Day‑1 Post‑Deploy Runbook
**Coolify on OCI**

## Purpose
This runbook documents the operational steps required after Terraform has completed successfully.

## Preconditions
- Terraform apply completed
- Control and worker nodes running
- SSH access via OCI console

---

## 1. Baseline Verification

### Control Node
```bash
hostname
uptime
docker version
docker compose version
docker run hello-world
