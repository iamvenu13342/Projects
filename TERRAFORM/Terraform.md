



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
