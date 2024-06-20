<h1> Serverless Application Deployment</h1>

<h2>Project Description:</h2>

Deploy a serverless application on AWS using AWS Lambda and API Gateway.


<h2>Key Components:</h2>

- **Lambda Function:** Define and deploy AWS Lambda functions.

- **API Gateway:** Create an API Gateway to trigger the Lambda functions.

- **IAM Roles:** Configure IAM roles and policies for Lambda execution.


<h2>Steps:</h2>

1. **Define Lambda Function:**
 
   ```hcl
   resource "aws_lambda_function" "my_lambda" {
     function_name = "my_lambda_function"
     handler       = "index.handler"
     runtime       = "nodejs14.x"
     role          = aws_iam_role.lambda_exec.arn
   
     filename      = "lambda_function_payload.zip"
     source_code_hash = filebase64sha256("lambda_function_payload.zip")
   }
   ```

2. **Create API Gateway:**

    ```hcl
   resource "aws_api_gateway_rest_api" "my_api" {
     name        = "MyAPI"
     description = "This is my API"
   }
   
   resource "aws_api_gateway_resource" "my_resource" {
     rest_api_id = aws_api_gateway_rest_api.my_api.id
     parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
     path_part   = "resource"
   }
   
   resource "aws_api_gateway_method" "my_method" {
     rest_api_id   = aws_api_gateway_rest_api.my_api.id
     resource_id   = aws_api_gateway_resource.my_resource.id
     http_method   = "POST"
     authorization = "NONE"
   }
   
   resource "aws_api_gateway_integration" "my_integration" {
     rest_api_id = aws_api_gateway_rest_api.my_api.id
     resource_id = aws_api_gateway_resource.my_resource.id
     http_method = aws_api_gateway_method.my_method.http_method
     integration_http_method = "POST"
     type        = "AWS_PROXY"
     uri         = aws_lambda_function.my_lambda.invoke_arn
   }
   ```

3. **Configure IAM Role:**

   ```hcl
   resource "aws_iam_role" "lambda_exec" {
     name = "lambda_exec_role"
   
     assume_role_policy = jsonencode({
       Version = "2012-10-17"
       Statement = [{
         Action = "sts:AssumeRole"
         Effect = "Allow"
         Principal = {
           Service = "lambda.amazonaws.com"
         }
       }]
     })
   }
   
   resource "aws_iam_role_policy_attachment" "lambda_policy" {
     role       = aws_iam_role.lambda_exec.name
     policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
   }
   ```

<h2> Benefits:</h2>

- **Cost-Efficiency:** Pay only for the compute time you use.

- **Scalability:** Automatically scale up and down based on demand.


<h2>Here are common issues and troubleshooting steps for each part of the project:</h2>

**1. AWS CLI Configuration Issues**

**2. IAM Permissions Issues**

**3. Terraform Initialization Issues**

**4. Lambda Function Deployment Issues**

**5. API Gateway Configuration Issues**

**6. IAM Role Configuration Issues**

