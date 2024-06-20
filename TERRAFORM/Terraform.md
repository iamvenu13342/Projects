Certainly! Here are a few more real-time Terraform projects with hands-on steps to illustrate various use cases:



### 6. **Infrastructure Monitoring Setup**
#### Project Description:
Set up monitoring for cloud infrastructure using Prometheus and Grafana on AWS.

#### Key Components:
- **EC2 Instances:** Deploy EC2 instances for Prometheus and Grafana.
- **Security Groups:** Configure security groups for secure access.
- **IAM Roles:** Create IAM roles with necessary permissions.

#### Steps:
1. **Provision EC2 Instances:**
   ```hcl
   resource "aws_instance" "prometheus" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
     subnet_id     = aws_subnet.main.id
     tags = {
       Name = "Prometheus"
     }
   }
   
   resource "aws_instance" "grafana" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
     subnet_id     = aws_subnet.main.id
     tags = {
       Name = "Grafana"
     }
   }
   ```
2. **Configure Security Groups:**
   ```hcl
   resource "aws_security_group" "monitoring_sg" {
     name        = "monitoring_sg"
     description = "Allow HTTP and HTTPS traffic"
     vpc_id      = aws_vpc.main.id
   
     ingress {
       from_port   = 80
       to_port     = 80
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }
   
     ingress {
       from_port   = 3000
       to_port     = 3000
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }
   
     egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
     }
   }
   ```
3. **IAM Role Configuration:**
   ```hcl
   resource "aws_iam_role" "prometheus_role" {
     name = "prometheus_role"
   
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
   
   resource "aws_iam_role_policy_attachment" "prometheus_policy" {
     role       = aws_iam_role.prometheus_role.name
     policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
   }
   ```

#### Benefits:
- **Visibility:** Gain insights into the performance and health of your infrastructure.
- **Alerting:** Set up alerts to respond to incidents proactively.

### 7. **Disaster Recovery Setup**
#### Project Description:
Set up disaster recovery for critical applications using Terraform to automate failover environments.

#### Key Components:
- **Secondary Region:** Define infrastructure in a secondary region.
- **Data Replication:** Automate data replication between primary and secondary regions.
- **Failover Mechanism:** Configure DNS and load balancers for automated failover.

#### Steps:
1. **Define Infrastructure in Secondary Region:**
   ```hcl
   provider "aws" {
     alias  = "secondary"
     region = "us-east-1"
   }
   
   resource "aws_instance" "secondary_web" {
     provider      = aws.secondary
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
     subnet_id     = aws_subnet.secondary.id
   }
   ```
2. **Automate Data Replication:**
   ```hcl
   resource "aws_dynamodb_table" "state_lock" {
     name         = "terraform-state-lock"
     billing_mode = "PAY_PER_REQUEST"
     hash_key     = "LockID"
   
     attribute {
       name = "LockID"
       type = "S"
     }
   }
   
   resource "aws_s3_bucket" "state_bucket" {
     bucket = "my-terraform-state-secondary"
     versioning {
       enabled = true
     }
     lifecycle_rule {
       id      = "expire-versions"
       enabled = true
   
       noncurrent_version_expiration {
         days = 30
       }
     }
   }
   ```
3. **Configure DNS and Load Balancers:**
   ```hcl
   resource "aws_route53_record" "failover" {
     zone_id = "Z3P5QSUBK4POTI"
     name    = "example.com"
     type    = "A"
   
     alias {
       name                   = aws_lb.primary.dns_name
       zone_id                = aws_lb.primary.zone_id
       evaluate_target_health = true
     }
   
     failover_routing_policy {
       type = "PRIMARY"
     }
   }
   
   resource "aws_route53_record" "failover_secondary" {
     zone_id = "Z3P5QSUBK4POTI"
     name    = "example.com"
     type    = "A"
   
     alias {
       name                   = aws_lb.secondary.dns_name
       zone_id                = aws_lb.secondary.zone_id
       evaluate_target_health = true
     }
   
     failover_routing_policy {
       type = "SECONDARY"
     }
   }
   ```

#### Benefits:
- **Resilience:** Ensure high availability and quick recovery from disasters.
- **Business Continuity:** Minimize downtime and maintain service availability.

### 8. **Identity and Access Management (IAM) Configuration**
#### Project Description:
Automate the configuration of IAM policies, roles, and users to manage access control.

#### Key Components:
- **IAM Users:** Create and manage IAM users.
- **IAM Policies:** Define and attach policies to users or roles.
- **IAM Roles:** Create roles for different services.

#### Steps:
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

#### Benefits:
- **Security:** Ensure proper access control and permissions.
- **Compliance:** Automate IAM configuration to meet compliance requirements.

These additional real-time Terraform projects provide more examples of how Terraform can be used to automate and manage various aspects of infrastructure and application deployment in different environments. Each project includes hands-on steps to guide you through the implementation process.





These hands-on projects demonstrate the practical applications of Terraform in real-world scenarios, showcasing its versatility in managing cloud infrastructure, multi-cloud environments, Kubernetes clusters, and CI/CD pipeline integration.
