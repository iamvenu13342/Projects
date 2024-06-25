<h1>Deploying the application in a Kubernetes cluster</h1>
involves several additional steps beyond using Docker and Jenkins. We need to:

1. **Create a Kubernetes Cluster**: This can be done using a managed service like Amazon EKS or a local setup like Minikube.
2. **Create Kubernetes Configuration Files**: Define your deployment, service, and other necessary resources.
3. **Update the Jenkins Pipeline**: Ensure it deploys to Kubernetes.

### Step 1: Create a Kubernetes Cluster

For simplicity, we’ll assume you're using Amazon EKS (Elastic Kubernetes Service).

#### Set Up Amazon EKS

1. **Install AWS CLI and eksctl**:
   - Follow the instructions for installing the AWS CLI [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
   - Follow the instructions for installing `eksctl` [here](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html).

2. **Configure AWS CLI**:
   ```sh
   aws configure
   ```

3. **Create an EKS Cluster**:
   ```sh
   eksctl create cluster --name my-cluster --region us-west-2 --nodegroup-name linux-nodes --node-type t2.micro --nodes 2
   ```

### Step 2: Create Kubernetes Configuration Files

Create the following files in your project directory:

1. **`k8s/deployment.yaml`**:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: your-app-deployment
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: your-app
     template:
       metadata:
         labels:
           app: your-app
       spec:
         containers:
         - name: your-app
           image: yourusername/your-app:latest
           ports:
           - containerPort: 3000
   ```

2. **`k8s/service.yaml`**:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: your-app-service
   spec:
     selector:
       app: your-app
     ports:
       - protocol: TCP
         port: 80
         targetPort: 3000
     type: LoadBalancer
   ```

### Step 3: Update Jenkins Pipeline

1. **Install Kubernetes CLI (kubectl) on Jenkins Server**:
   ```sh
   curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
   chmod +x ./kubectl
   sudo mv ./kubectl /usr/local/bin/kubectl
   ```

2. **Configure Jenkins to Access EKS Cluster**:
   - Ensure your Jenkins server can access your EKS cluster. Follow the [AWS EKS guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html) to set up `kubectl` with EKS.

3. **Update Jenkinsfile**:
   ```groovy
   pipeline {
       agent any
       environment {
           AWS_DEFAULT_REGION = 'us-west-2'
       }
       stages {
           stage('Build') {
               steps {
                   script {
                       def app = docker.build("yourusername/your-app")
                   }
               }
           }
           stage('Push') {
               steps {
                   script {
                       docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                           def app = docker.build("yourusername/your-app")
                           app.push("${env.BUILD_NUMBER}")
                           app.push("latest")
                       }
                   }
               }
           }
           stage('Deploy to Kubernetes') {
               steps {
                   script {
                       withAWS(region: 'us-west-2', credentials: 'aws-credentials-id') {
                           sh 'aws eks update-kubeconfig --name my-cluster --region us-west-2'
                       }
                       sh 'kubectl apply -f k8s/deployment.yaml'
                       sh 'kubectl apply -f k8s/service.yaml'
                   }
               }
           }
       }
   }
   ```

### Step 4: Commit and Push Changes

```sh
git add k8s/
git add Jenkinsfile
git commit -m "Add Kubernetes deployment configuration"
git push origin main
```

### Step 5: Execute the Pipeline

1. **Run the Pipeline**:
   - Go to Jenkins Dashboard -> your pipeline job -> Build Now.
   - Monitor the pipeline execution in the "Console Output".

### Step 6: Access the Deployed Application

- After a successful deployment, you can find the external IP of your service:
  ```sh
  kubectl get services
  ```
- Access your application using the external IP address.

### Conclusion

This setup expands your CI/CD pipeline to deploy your application into a Kubernetes cluster, leveraging AWS EKS, Docker, GitHub, and Jenkins. 
This provides a scalable and robust environment for your application.
