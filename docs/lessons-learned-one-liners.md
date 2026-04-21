# One-Sentence Lessons Learned

- OS choice affects time-to-truth and diagnosability, not just compatibility.
- Ubuntu provided clearer networking and TLS behavior than Oracle Linux for this workload.
- Cloud Shell is a separate environment and does not share files or SSH keys with OCI instances.
- Installer URLs can change, so always verify the canonical source before troubleshooting deeper layers.
- Docker Compose v2 is a hard requirement for Coolify; Docker Engine alone is insufficient.
- Terraform should provision infrastructure substrate only, not platform behavior.
- SSH trust between control and worker nodes is an explicit Day-1 operational responsibility.
- SSH authentication requires a private key on disk; public keys alone are insufficient.
- Coolify manages the localhost server SSH identity internally and it should not be modified.
- DNS errors such as NXDOMAIN may indicate deprecated endpoints rather than network failures.
- Enterprise or cloud defaults can obscure root causes if ownership boundaries are unclear.
- Not all security warnings represent failures; some are hardening recommendations.
- HSTS should be enabled only after HTTPS and domain configuration are stable.
- WebSockets and realtime services depend on consistent HTTPS termination through Traefik.
- Separating Day-0 (IaC) and Day-1 (operations) responsibilities reduces complexity and drift.
- Clean rebuilds are often faster and safer than repairing partial bootstrap state.
- Explicit documentation of assumptions prevents repeated troubleshooting cycles.
- Reducing variables is often the fastest path to identifying the true constraint.

