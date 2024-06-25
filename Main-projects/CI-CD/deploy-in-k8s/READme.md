<h1>End-to-End Real-time project using AWS, GitHub, Jenkins, and Kubernetes </h1>
   involves several steps. Here’s a detailed guide along with all commands and the project directory structure.

### Project Directory Structure

```
your-repo/
├── app.js
├── Dockerfile
├── .dockerignore
├── Jenkinsfile
├── package.json
├── package-lock.json
├── README.md
└── k8s/
    ├── deployment.yaml
    └── service.yaml
```

### Step 1: Set Up GitHub Repository

1. **Create a GitHub Repository:**
   - Go to GitHub and create a new repository named `your-repo`.
   - Clone the repository to your local machine:
     ```sh
     git clone https://github.com/yourusername/your-repo.git
     cd your-repo
     ```

### Step 2: Add a Simple Web Application

2. **Create `package.json` and Install Dependencies:**
   ```sh
   npm init -y
   npm install express
   ```

3. **Create `app.js`:**
   ```javascript
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/', (req, res) => {
     res.send('Hello World!');
   });

   app.listen(port, () => {
     console.log(`App listening at http://localhost:${port}`);
   });
   ```

4. **Create `Dockerfile`:**
   ```dockerfile
   FROM node:14
   WORKDIR /usr/src/app
   COPY package*.json ./
   RUN npm install
   COPY . .
   EXPOSE 3000
   CMD [ "node", "app.js" ]
   ```

5. **Create `.dockerignore`:**
   ```
   node_modules
   npm-debug.log
   ```

6. **Create Kubernetes Deployment File `k8s/deployment.yaml`:**
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

7. **Create Kubernetes Service File `k8s/service.yaml`:**
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

8. **Create Jenkinsfile:**
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

### Step 3: Commit and Push Changes

```sh
git add .
git commit -m "Initial project structure"
git push origin main
```

### Step 4: Set Up Jenkins on AWS

1. **Launch an EC2 Instance:**
   - Log in to AWS Management Console.
   - Launch a new EC2 instance (Ubuntu Server 20.04 LTS).
   - Configure security group to allow HTTP (port 80), SSH (port 22), and custom TCP rule (port 8080 for Jenkins).

2. **Connect to EC2 Instance:**
   ```sh
   ssh -i "your-key-pair.pem" ubuntu@your-ec2-public-dns
   ```

3. **Install Jenkins:**
   - Install Java:
     ```sh
     sudo apt update
     sudo apt install openjdk-11-jdk -y
     ```
   - Add Jenkins repository and key:
     ```sh
     wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
     sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
     ```
   - Install Jenkins:
     ```sh
     sudo apt update
     sudo apt install jenkins -y
     ```
   - Start Jenkins:
     ```sh
     sudo systemctl start jenkins
     sudo systemctl enable jenkins
     ```
   - Access Jenkins at `http://your-ec2-public-dns:8080`.

4. **Set Up Jenkins:**
   - Unlock Jenkins using the password from `/var/lib/jenkins/secrets/initialAdminPassword`.
   - Install suggested plugins.
   - Create an admin user.

### Step 5: Install and Configure Tools on Jenkins Server

1. **Install Docker:**
   ```sh
   sudo apt install docker.io -y
   sudo usermod -aG docker jenkins
   sudo systemctl restart jenkins
   ```

2. **Install Kubernetes CLI (kubectl):**
   ```sh
   curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
   chmod +x ./kubectl
   sudo mv ./kubectl /usr/local/bin/kubectl
   ```

3. **Install AWS CLI:**
   ```sh
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   ```

4. **Configure AWS CLI:**
   ```sh
   aws configure
   ```

5. **Install Git and Docker Plugins in Jenkins:**
   - Go to Jenkins Dashboard -> Manage Jenkins -> Manage Plugins.
   - Install Git and Docker plugins.

### Step 6: Create Kubernetes Cluster

1. **Install eksctl:**
   ```sh
   curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   sudo mv /tmp/eksctl /usr/local/bin
   ```

2. **Create an EKS Cluster:**
   ```sh
   eksctl create cluster --name my-cluster --region us-west-2 --nodegroup-name linux-nodes --node-type t2.micro --nodes 2
   ```

### Step 7: Update Jenkins Pipeline

1. **Add AWS and Docker credentials in Jenkins**:
   - Go to Jenkins Dashboard -> Manage Jenkins -> Manage Credentials -> (global) -> Add Credentials.
   - Add DockerHub credentials with ID `dockerhub-credentials`.
   - Add AWS credentials with ID `aws-credentials-id`.

2. **Run the Pipeline**:
   - Go to Jenkins Dashboard -> your pipeline job -> Build Now.
   - Monitor the pipeline execution in the "Console Output".

### Step 8: Access the Deployed Application

- After a successful deployment, you can find the external IP of your service:
  ```sh
  kubectl get services
  ```
- Access your application using the external IP address.

### Conclusion

This setup provides a comprehensive end-to-end solution for deploying a web application using AWS, GitHub, Jenkins, and Kubernetes. The project directory structure ensures that all components are well-organized, making it easier to manage and extend the application in the future.

### Conclusion

This setup expands your CI/CD pipeline to deploy your application into a Kubernetes cluster, leveraging AWS EKS, Docker, GitHub, and Jenkins. 
This provides a scalable and robust environment for your application.
