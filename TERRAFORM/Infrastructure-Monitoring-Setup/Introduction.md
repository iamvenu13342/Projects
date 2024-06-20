
<h1> Infrastructure Monitoring Setup</h1>

<h2>Project Description:</h2>

Set up monitoring for cloud infrastructure using Prometheus and Grafana on AWS.


<h2>Key Components:</h2>
  
- **EC2 Instances:** Deploy EC2 instances for Prometheus and Grafana.

- **Security Groups:** Configure security groups for secure access.

- **IAM Roles:** Create IAM roles with necessary permissions.


<h2>Steps:</h2>.

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

3. **Configure Security Groups:**
 
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

4. **IAM Role Configuration:**

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


<h2>Benefits:</h2>

- **Visibility:** Gain insights into the performance and health of your infrastructure.

- **Alerting:** Set up alerts to respond to incidents proactively.

- 
