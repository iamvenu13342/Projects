<h1> Identity and Access Management (IAM) Configuration</h1>

<h2> Project Description:</h2>

Automate the configuration of IAM policies, roles, and users to manage access control.

<h2>Key Components:</h2>

- **IAM Users:** Create and manage IAM users.

- **IAM Policies:** Define and attach policies to users or roles.

- **IAM Roles:** Create roles for different services.


<h2>Steps:</h2>


1. **Create IAM Users:**

    ```hcl
   resource "aws_iam_user" "user" {
     name = "deploy_user"
   }
   
   resource "aws_iam_access_key" "user_key" {
     user = aws_iam_user.user.name
   }
   ```

2. **Define IAM Policies:**

    ```hcl
   resource "aws_iam_policy" "deploy_policy" {
     name        = "deploy_policy"
     description = "A policy for deployment"
     policy      = jsonencode({
       Version = "2012-10-17"
       Statement = [
         {
           Action = [
             "ec2:Describe*",
             "s3:List*"
           ],
           Effect   =

 "Allow",
           Resource = "*"
         },
         {
           Action = "s3:GetObject",
           Effect = "Allow",
           Resource = "arn:aws:s3:::mybucket/*"
         }
       ]
     })
   }
   ```

3. **Attach Policies to Users/Roles:**
  
   ```hcl
   resource "aws_iam_role_policy_attachment" "attach_policy" {
     role       = aws_iam_role.role.name
     policy_arn = aws_iam_policy.deploy_policy.arn
   }
   
   resource "aws_iam_user_policy_attachment" "user_policy" {
     user       = aws_iam_user.user.name
     policy_arn = aws_iam_policy.deploy_policy.arn
   }
   ```

<h2> Benefits:</h2>

- **Security:** Ensure proper access control and permissions.

- **Compliance:** Automate IAM configuration to meet compliance requirements.

<h1>Common Issues and Troubleshooting</h1>

**1. Error in Policy JSON Formatting:**

**2. Missing Variables or Incorrect Values:**

**3. Incorrect Module Source Path:**

**4. Dependency Issues in Resource Creation:**

**5. Terraform State Backend Configuration Issues:**



