 <h1> `main.tf` file:</h1>

```hcl
provider "aws" {
  region = "us-west-2"
}

# AWS VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "ExampleVPC"
  }
}

# AWS EC2 Instance
resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.example_subnet.id
  tags = {
    Name = "ExampleInstance"
  }
}

# AWS S3 Bucket
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-example-bucket"
  acl    = "private"
}

# AWS IAM User
resource "aws_iam_user" "example_user" {
  name = "example-user"
}

# AWS RDS MySQL Database Instance
resource "aws_db_instance" "example_db_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "myexampledb"
  username             = "admin"
  password             = "Admin12345"
}

# AWS Route 53 DNS Record
resource "aws_route53_record" "example_dns_record" {
  zone_id = "Z3M3LMPEXAMPLE"
  name    = "example.com"
  type    = "A"
  ttl     = "300"
  records = ["1.2.3.4"]
}

# AWS Lambda Function
resource "aws_lambda_function" "example_lambda_function" {
  function_name = "example_lambda"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  source_code_hash = filebase64sha256("path/to/lambda_function.zip")
}

# AWS IAM Role
resource "aws_iam_role" "example_role" {
  name = "example-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# AWS SNS Topic
resource "aws_sns_topic" "example_topic" {
  name = "example-topic"
}

# AWS DynamoDB Table
resource "aws_dynamodb_table" "example_table" {
  name           = "example-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }
}

# AWS Subnet
resource "aws_subnet" "example_subnet" {
  vpc_id     = aws_vpc.example_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "ExampleSubnet"
  }
}
```


### Explanation:
- **AWS EC2 Instance**: Creates a single EC2 instance with a specific AMI and instance type.
- **AWS S3 Bucket**: Defines an S3 bucket with a private ACL.
- **AWS IAM User**: Creates an IAM user named "example-user".
- **AWS RDS MySQL Database Instance**: Sets up an RDS MySQL database instance with specified parameters.
- **AWS Route 53 DNS Record**: Defines a DNS record in Route 53 for the domain "example.com".
- **AWS Lambda Function**: Sets up a Lambda function named "example_lambda".
- **AWS IAM Role**: Creates an IAM role with a trust policy allowing Lambda to assume the role.
- **AWS SNS Topic**: Defines an SNS topic named "example-topic".
- **AWS DynamoDB Table**: Creates a DynamoDB table with PAY_PER_REQUEST billing mode and a hash key attribute.
- **AWS VPC (`aws_vpc.example_vpc`)**: Creates a VPC with CIDR block `10.0.0.0/16`, enabling DNS support and hostnames.
- **AWS Subnet (`aws_subnet.example_subnet`)**: Creates a subnet (`10.0.1.0/24`) within the VPC `aws_vpc.example_vpc` in availability zone `us-west-2a`.
- **Other Resources**: These remain unchanged from the previous example.

