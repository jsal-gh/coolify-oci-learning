# Deploy via OCI Resource Manager (No ZIP Needed)
Because you’re using GitHub web:
✅ Do NOT download ZIPs
✅ Do NOT manage Terraform locally

## OCI Resource Manager (GitHub source – best option)

1. OCI Console → **Developer Services → Resource Manager**
2. **Create Stack**
3. Terraform config source → **GitHub**
4. Authorise GitHub (one-time)
5. Select:
 - Org/User
 - Repo: coolify-oci-learning
 - Branch: main
6. Continue → input variables
7. **Plan → Apply**

OCI will:
 - Pull the repo directly
 - Manage Terraform state
 - Track history
 - Allow re-runs safely
