# Architecture Overview
**Self‑Hosted Platform on OCI using Coolify**

## Purpose
This document describes the high‑level architecture of a self‑hosted application platform deployed on Oracle Cloud Infrastructure (OCI) using Coolify. It focuses on **design intent and decisions**, not implementation steps.

## Goals
- Provide a lightweight, self‑hosted PaaS for learning and experimentation
- Minimise managed cloud services
- Use infrastructure‑as‑code for reproducibility
- Keep operational complexity low
- Prefer observability and debuggability over abstraction

## Non‑Goals
- High availability or multi‑region
- Kubernetes
- Production‑grade SLAs
- OCI‑native PaaS services
- Deep security hardening beyond sensible defaults

## High‑Level Architecture

`       Internet
          |
     HTTPS (443)
          v
+----------------------+
|  Traefik (Coolify)   |
|  - TLS (Let's Encrypt)
|  - WebSockets        |
+----------------------+
          |
     Docker network
          v
+----------------------+
|  Coolify Control     |
|  - UI / API          |
|  - Realtime service  |
+----------------------+
          |
       SSH (22)
          v
+----------------------+
|  Worker Node         |
|  - Application containers
+----------------------+`

## Key Components

### OCI
- Single VCN
- Public subnet
- Network Security Groups (NSGs)
- Internet Gateway

### Control Node
- Ubuntu 22.04 LTS
- Docker Engine
- Docker Compose v2
- Coolify
- Traefik (managed internally by Coolify)

### Worker Node
- Ubuntu 22.04 LTS
- Docker Engine
- Docker Compose v2
- No public inbound access required

## Key Design Decisions

### Coolify vs Kubernetes
Coolify was chosen to:
- Reduce operational overhead
- Avoid cluster management
- Focus on platform behaviour rather than orchestration complexity

### Traefik vs OCI Load Balancer
Traefik (via Coolify):
- Handles TLS termination
- Supports WebSockets
- Eliminates need for OCI Load Balancer
- Keeps architecture simple and portable

### Ubuntu vs Oracle Linux
Ubuntu 22.04 was selected due to:
- Predictable DNS and TLS behaviour
- Clear ownership of networking stack
- Easier diagnosis of failures
- Better alignment with Coolify documentation

### Trust Model
- Control node connects to workers via SSH
- SSH trust is explicit and operational (Day‑1)
- Terraform does not manage SSH trust relationships

## Responsibility Boundaries

| Concern | Owner |
|------|------|
| Infrastructure provisioning | Terraform |
| OS baseline | Terraform + cloud‑init |
| Platform installation | Post‑deploy runbook |
| Platform operation | Coolify |
| Application lifecycle | Coolify |
| SSH trust | Operations |

## Summary
This architecture deliberately favours **clarity over completeness**. Each layer has a clear owner, and responsibilities are not blurred across tools.
