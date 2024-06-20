Certainly! Here are a few more real-time Terraform projects with hands-on steps to illustrate various use cases:





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



These additional real-time Terraform projects provide more examples of how Terraform can be used to automate and manage various aspects of infrastructure and application deployment in different environments. Each project includes hands-on steps to guide you through the implementation process.





These hands-on projects demonstrate the practical applications of Terraform in real-world scenarios, showcasing its versatility in managing cloud infrastructure, multi-cloud environments, Kubernetes clusters, and CI/CD pipeline integration.
