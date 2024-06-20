<h1> EKS Cluster Provisioning with Terraform</h1>

This project automates the provisioning of a Kubernetes cluster on AWS using EKS with Terraform.

<h2>Directory Structure</h2>

- `modules/eks/`: EKS-specific Terraform configurations.
- `modules/node_groups/`: Node group-specific Terraform configurations.
- `iam_roles.tf`: Defines necessary IAM roles and policies.
- `main.tf`: Main Terraform file that calls the provider-specific modules.
- `variables.tf`: Defines global variables.
- `outputs.tf`: Defines global output values.
- `backend.tf`: Configures remote state management.
- `providers.tf`: Defines providers for AWS.

<h2>Usage</h2>

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/eks-cluster.git
   cd eks-cluster

   
