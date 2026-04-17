# Day‑0 Terraform Build Guide  
**OCI + Coolify Baseline**

## Purpose
Defines what Terraform provisions and what it intentionally does not.

## Guaranteed Outcomes
- VCN, subnet, routing
- Control + worker nodes
- Ubuntu 22.04 LTS
- Docker Engine
- Docker Compose v2
- Correct NSGs

Terraform does **not** install Coolify.

## Explicit Non‑Goals
- Coolify installation
- TLS configuration
- Worker registration
- Email configuration
- App deployment
