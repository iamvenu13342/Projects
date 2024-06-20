



### 3. **Kubernetes Cluster Provisioning**
#### Project Description:
Automate the provisioning of a Kubernetes cluster on AWS using EKS (Elastic Kubernetes Service).

#### Key Components:
- **EKS Provider:** Use Terraform’s EKS provider to manage Kubernetes clusters.
- **Node Groups:** Define and manage node groups within the cluster.
- **IAM Roles and Policies:** Configure necessary IAM roles and policies.

#### Steps:
1. **Setup EKS Cluster:**
   ```hcl
   module "eks" {
     source          = "terraform-aws-modules/eks/aws"
     cluster_name    = "my-cluster"
     cluster_version = "1.21"
     subnets         = module.vpc.private_subnets
     vpc_id          = module.vpc.vpc_id
   }
   ```
2. **Define Node Group:**
   ```hcl
   module "eks_workers" {
     source          = "terraform-aws-modules/eks/aws//modules/node_groups"
     cluster_name    = module.eks.cluster_name
     node_group_name = "example"
     node_group_desired_capacity = 2
     node_group_max_capacity     = 3
     node_group_min_capacity     = 1
   }
   ```
3. **Configure IAM Roles:**
   ```hcl
   resource "aws_iam_role" "eks_node_group" {
     name = "eks-node-group-role"
   
     assume_role_policy = jsonencode({
       Version = "2012-10-17"
       Statement = [{
         Action = "sts:AssumeRole"
         Effect = "Allow"
         Principal = {
           Service = "ec2.amazonaws.com"
         }
       }]
     })
   }
   
   resource "aws_iam_role_policy_attachment" "eks_worker_attach" {
     role       = aws_iam_role.eks_node_group.name
     policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
   }
   ```

#### Benefits:
- **Ease of Management:** Simplifies the management of Kubernetes clusters.
- **Scalability:** Easily scale the cluster by adjusting node group configurations.

### 4. **CI/CD Pipeline Integration**
#### Project Description:
Integrate Terraform with a CI/CD pipeline to automate the deployment of infrastructure changes.

#### Key Components:
- **CI/CD Tools:** Use Jenkins, GitLab CI, or GitHub Actions.
- **Terraform Commands:** Run Terraform commands (`terraform init`, `terraform plan`, `terraform apply`) as part of the pipeline.
- **Remote State Management:** Ensure state is stored remotely for consistency.

#### Steps:
1. **Jenkins Pipeline Configuration:**
   ```groovy
   pipeline {
       agent any
       stages {
           stage('Terraform Init') {
               steps {
                   sh 'terraform init'
               }
           }
           stage('Terraform Plan') {
               steps {
                   sh 'terraform plan'
               }
           }
           stage('Terraform Apply') {
               steps {
                   sh 'terraform apply -auto-approve'
               }
           }
       }
   }
   ```
2. **GitLab CI Configuration:**
   ```yaml
   stages:
     - init
     - plan
     - apply
   
   init:
     script:
       - terraform init
   
   plan:
     script:
       - terraform plan
   
   apply:
     script:
       - terraform apply -auto-approve
   ```
3. **GitHub Actions Configuration:**
   ```yaml
   name: 'Terraform CI'
   
   on:
     push:
       branches:
         - main
   
   jobs:
     terraform:
       name: 'Terraform'
       runs-on: ubuntu-latest
       steps:
         - name: Checkout code
           uses: actions/checkout@v2
         - name: Setup Terraform
           uses: hashicorp/setup-terraform@v1
           with:
             terraform_version: 0.14.7
         - name: Terraform Init
           run: terraform init
         - name: Terraform Plan
           run: terraform plan
         - name: Terraform Apply
           run: terraform apply -auto-approve
   ```

#### Benefits:
- **Automation:** Reduces manual intervention in infrastructure management.
- **Consistency:** Ensures infrastructure changes are reviewed and applied consistently.

These hands-on projects demonstrate the practical applications of Terraform in real-world scenarios, showcasing its versatility in managing cloud infrastructure, multi-cloud environments, Kubernetes clusters, and CI/CD pipeline integration.
