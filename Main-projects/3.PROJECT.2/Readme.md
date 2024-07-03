<h1>include Docker for containerization</h1>

Sure! Let's expand the project to include Docker for containerization. Here's a detailed guide on creating a CI/CD pipeline using AWS EC2, GitHub, Jenkins, and Docker.

### Step 1: Setting up an AWS EC2 Instance

1. **Launch an EC2 Instance**:
   - Go to the AWS Management Console.
   - Navigate to the EC2 Dashboard and click on "Launch Instance".
   - Choose an Amazon Machine Image (AMI), preferably Ubuntu Server.
   - Select an instance type (t2.micro is usually sufficient for a small project).
   - Configure instance details, add storage, and add tags if necessary.
   - Configure the security group to allow HTTP (port 80), HTTPS (port 443), and SSH (port 22) access.
   - Review and launch the instance. Download the key pair (.pem file) if you don't already have one.

2. **Connect to Your Instance**:
   - Open your terminal.
   - Connect to the instance using SSH:
     ```bash
     ssh -i /path/to/your-key-pair.pem ubuntu@your-ec2-public-dns
     ```

### Step 2: Install Jenkins and Docker on the EC2 Instance

1. **Install Java**:
   ```bash
   sudo apt update
   sudo apt install openjdk-11-jdk -y
   ```

2. **Add Jenkins Repository and Install Jenkins**:
   ```bash
   wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
   sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
   sudo apt update
   sudo apt install jenkins -y
   ```

3. **Start Jenkins**:
   ```bash
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   ```

4. **Install Docker**:
   ```bash
   sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   sudo apt update
   sudo apt install docker-ce -y
   sudo usermod -aG docker $USER
   ```

5. **Restart Your Shell Session**:
   ```bash
   exit
   ssh -i /path/to/your-key-pair.pem ubuntu@your-ec2-public-dns
   ```

6. **Install Docker Compose**:
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```

7. **Open Jenkins Web Interface**:
   - Open your browser and navigate to `http://your-ec2-public-dns:8080`.
   - Retrieve the initial admin password:
     ```bash
     sudo cat /var/lib/jenkins/secrets/initialAdminPassword
     ```
   - Follow the instructions to set up Jenkins and install the suggested plugins.

### Step 3: Set up GitHub Repository

1. **Create a GitHub Repository**:
   - Go to GitHub and create a new repository (e.g., `simple-ci-cd-docker`).

2. **Clone the Repository to Your Local Machine**:
   ```bash
   git clone https://github.com/your-username/simple-ci-cd-docker.git
   cd simple-ci-cd-docker
   ```

3. **Add a Simple Dockerized Application**:
   - Create a simple Python web application (`app.py`):
     ```python
     from flask import Flask
     app = Flask(__name__)

     @app.route('/')
     def hello():
         return "Hello, World!"

     if __name__ == "__main__":
         app.run(host='0.0.0.0', port=5000)
     ```

   - Create a `Dockerfile`:
     ```Dockerfile
     FROM python:3.8-slim

     WORKDIR /app
     COPY app.py /app

     RUN pip install flask

     CMD ["python", "app.py"]
     ```

   - Create a `docker-compose.yml`:
     ```yaml
     version: '3'
     services:
       web:
         build: .
         ports:
           - "5000:5000"
     ```

4. **Push Changes to GitHub**:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

### Step 4: Configure Jenkins for CI/CD with Docker

1. **Install Jenkins Plugins**:
   - Go to "Manage Jenkins" > "Manage Plugins".
   - Install the following plugins:
     - Docker Pipeline
     - GitHub Integration Plugin
     - Pipeline Plugin

2. **Create a New Jenkins Pipeline Job**:
   - Go to the Jenkins dashboard.
   - Click on "New Item", enter a name for your job, select "Pipeline", and click "OK".

3. **Configure the Job**:
   - Under "Pipeline", select "Pipeline script from SCM".
   - Choose "Git" and enter your repository URL (e.g., `https://github.com/your-username/simple-ci-cd-docker.git`).
   - If your repository is private, you'll need to add your GitHub credentials.
   - Specify the script path as `Jenkinsfile`.

4. **Create a Jenkinsfile in Your Repository**:
   ```groovy
   pipeline {
       agent any

       stages {
           stage('Checkout') {
               steps {
                   git 'https://github.com/your-username/simple-ci-cd-docker.git'
               }
           }
           stage('Build Docker Image') {
               steps {
                   script {
                       dockerImage = docker.build("simple-ci-cd-docker")
                   }
               }
           }
           stage('Run Docker Container') {
               steps {
                   script {
                       dockerImage.run('-p 5000:5000')
                   }
               }
           }
       }
   }
   ```

5. **Save and Build**:
   - Save the job configuration.
   - Click "Build Now" to trigger a build manually.

### Step 5: Set Up Webhook for Automatic Builds

1. **Set up GitHub Webhook**:
   - Go to your GitHub repository settings.
   - Under "Webhooks", click "Add webhook".
   - Enter the payload URL as `http://your-ec2-public-dns:8080/github-webhook/`.
   - Select "application/json" as the content type.
   - Add a secret (optional) and click "Add webhook".

2. **Configure Jenkins to Receive Webhooks**:
   - Go to your Jenkins job configuration.
   - In the "Build Triggers" section, check "GitHub hook trigger for GITScm polling".
   - Save the configuration.

### Testing the CI/CD Pipeline

1. **Make a Change in the Repository**:
   - Edit the `app.py` file or any other file in your local repository.
   - Commit and push the changes to GitHub:
     ```bash
     git add .
     git commit -m "Updated app.py"
     git push origin main
     ```

2. **Check Jenkins**:
   - Go to your Jenkins dashboard.
   - Verify that a new build is triggered automatically by the webhook.

Congratulations! You've set up a full CI/CD pipeline using AWS EC2, GitHub, Jenkins, and Docker. Now, every time you push changes to your GitHub repository, Jenkins will automatically build a Docker image, run the container, and ensure your application is up-to-date.
