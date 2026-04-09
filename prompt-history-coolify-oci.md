
# Prompt History – Coolify on OCI Design Session

This file contains the full, chronological list of prompts used during the Coolify on OCI architecture session.

## Prompt List

1. provide high-level steps for architecting a self-hosted coolify solution on oci

2. Refine the plan as follows:
   1. Keep the implementation as simple as possible to leverage the capabilities of coolify including traefik and certificate management. I feel that there may be no need for an OCI load balancer as coolify and traefik should handle this resulting in a simpler implementation
   2. Workload profile - this is a learning project and expecting only a small number of applications and only a handful of concurrent connections expected. Most applications will need to be internet facing. Please consider this when suggesting private vs public subnets and placement of compute instances.
   3. Deployment is to a single region only
   4. Provide suggestions for SDLC and migration between environments; keep it practical and only as complex as it needs to be but no more
   5. I feel that it may be best to kick off with the following worker strategy: A single compute instance for the coolify control plane is fine. A single compute instance for workloads. Pls suggest cpu, mem, storage for each of the compute instances. Be aware that deployed resources should amount to no more than the maximum available in Oracle's free tier. If you recommend a single compute instance for control and worker, please advise.
   6. Create a reference architecture diagram showing the various components and high-level detail
   7. Recommend OS version
   8. The model should allow for future worker growth, if required. (this would be outside of the free tier cap)
   9. Infrastructure automation is ideal should there be a need to create separate instances; please provide help with Terraform modules

3. Detail block volume backup strategy

4. Provide actual Terraform module examples

5. Please update security to use NSGs
   Can you provide a final document (docx) with this design and terraform scripts?

6. Please redo the reference architecture document to include all of the current detail presented in this chat. Include all of the terraform scripts. Please use headings and include a table of contents.

7. Please proceed with next steps 1 and 3 and update the document accordingly

8. Provide a full list of my prompts this morning

9. Convert final design into ADR format. Export prompt list as markdown file.
