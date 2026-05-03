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

## Coolify extended infrastructure architecture

```mermaid
graph TD
    %% User Interface
    User[Developer] -->|Access UI / API| UI(Coolify Dashboard/API)
    Git[Git Provider - GitHub/GitLab] -.->|Webhook| API

    subgraph ControlNode [Control Plane Server - Coolify Installed]
        UI --> API{Coolify Core Engine}
        API --> DB[(Internal PostgreSQL)]
        API --> Proxy[Traefik Proxy - External]
        
        %% Core Components on Control Node
        API -->|Manages| P1[Project A]
        API -->|Manages| P2[Project B]
    end

    %% Connection
    API ==>|SSH + Docker Socket| W1
    API ==>|SSH + Docker Socket| W2

    subgraph WorkerNode1 [Worker Node 1 - Remote Server]
        W1(Docker Engine)
        W1 --> App1[Application Container]
        W1 --> DB1[Database Container]
    end

    subgraph WorkerNode2 [Worker Node 2 - Remote Server]
        W2(Docker Engine)
        W2 --> App2[Application Container]
        W2 --> DB2[Database Container]
    end

    %% Styling
    classDef control fill:#0071ff,stroke:#0056c7,stroke-width:2px,color:white;
    classDef worker fill:#111,stroke:#333,stroke-width:2px,color:white;
    classDef git fill:#f6f8fa,stroke:#333,stroke-width:1px;
    
    class API,DB,Proxy,UI,P1,P2 control;
    class W1,W2,App1,App2,DB1,DB2 worker;
    class Git git;
```
