<h1> Automated Cloud Infrastructure Provisioning</h1>


<h2>Project Description:</h2>

Automate the provisioning of a full-stack application infrastructure on AWS, including VPC, subnets, security groups, EC2 instances, RDS databases, and S3 buckets.


<h2>Key Components:</h2>

- **AWS Provider:** Used to interact with AWS resources.

- **Modules:** Separate infrastructure into reusable modules, such as `network`, `compute`, and `database`.

- **State Management:** Store the state in a remote backend like S3 with DynamoDB for state locking.


<h2>Steps:</h2>

**1. Setup AWS Credentials:**
   
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }
   ```

**2. Define VPC:**
  
   ```hcl
   resource "aws_vpc" "main" {
     cidr_block = "10.0.0.0/16"
   }
   ```

 **3. Create EC2 Instance:**
 
   ```hcl
   resource "aws_instance" "web" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
     subnet_id     = aws_subnet.main.id
   }
   ```

**4. Remote State Storage:**
 
   ```hcl
   terraform {
     backend "s3" {
       bucket = "my-terraform-state"
       key    = "global/s3/terraform.tfstate"
       region = "us-west-2"
       dynamodb_table = "terraform-lock"
     }
   }
   ```


<h2>Benefits:</h2>

- **Consistency:** Ensures the infrastructure is provisioned the same way every time.

- **Scalability:** Easily scale up or down by adjusting parameters in the Terraform configuration.



<h2>Common Issues and Resolutions</h2>

1. **AWS Credentials and Permissions:**

2. **VPC and Subnet Configuration:**

3. **Security Groups:**

4. **EC2 Instance Configuration:**

5. **Remote State Configuration:**

6. **Module Reusability:**

   
