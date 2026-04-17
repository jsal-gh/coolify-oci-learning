# Day‑1 Post‑Deploy Runbook
**Coolify on OCI**

## Purpose
This runbook documents the operational steps required after Terraform has completed successfully.

---

## Preconditions
- Terraform apply completed
- Control and worker nodes running
- OCI console access available

---

## 1. Baseline Verification

```bash
hostname
uptime
docker version
docker compose version
docker run hello-world
``
