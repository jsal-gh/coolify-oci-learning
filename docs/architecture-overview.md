# Architecture Overview  
**Self‑Hosted Platform on OCI using Coolify**

## Purpose
This document describes the high‑level architecture of a self‑hosted application platform deployed on Oracle Cloud Infrastructure (OCI) using Coolify. It focuses on design intent and architectural decisions rather than implementation steps.

## Goals
- Lightweight, self‑hosted PaaS for learning and experimentation
- Minimal use of managed cloud services
- Infrastructure‑as‑Code for reproducibility
- Clear operational ownership boundaries
- High debuggability over abstraction

## Non‑Goals
- High availability or multi‑region
- Kubernetes
- Production SLAs
- OCI‑native PaaS services
- Deep security hardening beyond sensible defaults

## High‑Level Architecture Diagram

```mermaid
flowchart TB
    Internet["Internet"]
    Traefik["Traefik<br/>(TLS, WebSockets)"]
    Control["Coolify Control Node<br/>(UI, API, Realtime)"]
    Worker["Worker Node<br/>(Application Containers)"]

    Internet -->|HTTPS 443| Traefik
    Traefik --> Control
    Control -->|SSH 22| Worker

    subgraph OCI ["Oracle Cloud Infrastructure"]
        Traefik
        Control
        Worker
    end
```

## Responsibility Boundaries

| Concern | Owner |
|------|------|
| Infrastructure provisioning | Terraform |
| OS baseline | Terraform + cloud‑init |
| Platform installation | Post‑deploy runbook |
| Platform operation | Coolify |
| Application lifecycle | Coolify |
| SSH trust | Operations |
