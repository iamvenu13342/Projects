<h1>Multi-Cloud Terraform Deployment</h1>

This project manages infrastructure across AWS, Azure, and GCP using Terraform.

<h2>Directory Structure</h2>

- `aws/`: AWS-specific Terraform configurations.

- `azure/`: Azure-specific Terraform configurations.

- `gcp/`: GCP-specific Terraform configurations.

- `providers.tf`: Defines providers for AWS, Azure, and GCP.

- `backend.tf`: Configures remote state management.

- `main.tf`: Main Terraform file that calls the provider-specific modules.


<h2>Usage</h2>

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/multi-cloud-terraform.git
   cd multi-cloud-terraform

2. Initialize Terraform:

   terraform init

3. Plan the deployment:

   terraform plan

4. Apply the deployment:

   terraform apply -auto-approve
