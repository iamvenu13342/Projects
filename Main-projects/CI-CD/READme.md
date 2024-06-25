<H1>End-to-End Real-Time Project Setup Using AWS, GitHub, Jenkins, and Docker</H1>

This guide will walk you through creating a continuous integration and continuous deployment (CI/CD) pipeline for a simple web application. We'll use the following technologies:

- **AWS**: For hosting the Jenkins server and Docker containers.

- **GitHub**: For version control.

- **Jenkins**: For continuous integration and deployment.

- **Docker**: For containerization.

### Prerequisites

- AWS account

- GitHub account

- Basic knowledge of Docker and Jenkins

### Step 1: Set Up GitHub Repository

1. **Create a GitHub Repository:**

    - Go to GitHub and create a new repository.

    - Clone the repository to your local machine:

     ```sh
     git clone https://github.com/yourusername/your-repo.git
     cd your-repo
     ```

2. **Add a Simple Web Application:**

    - Create a basic Node.js application:

    ```sh
     npm init -y
     npm install express
     ```


 - Create `app.js`:

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

3. **Push to GitHub:**

   - Add, commit, and push your changes:
   
     ```sh
     git add .
     git commit -m "Initial commit"
     git push origin main
     ```

### Step 2: Set Up Docker

1. **Create a `Dockerfile`:**

    ```dockerfile
   FROM node:14
   WORKDIR /usr/src/app
   COPY package*.json ./
   RUN npm install
   COPY . .
   EXPOSE 3000
   CMD [ "node", "app.js" ]
   ```

2. **Create a `.dockerignore` File:**

    ```
   node_modules
   npm-debug.log
   ```

3. **Build and Run Docker Container Locally:**

    - Build the Docker image:

      ```sh
     docker build -t yourusername/your-app .
     ```

    - Run the Docker container:

     ```sh
     docker run -p 3000:3000 -d yourusername/your-app
     ```

    - Verify the application is running at `http://localhost:3000`.

### Step 3: Set Up Jenkins on AWS

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

### Step 4: Configure Jenkins for CI/CD

1. **Install Docker on Jenkins Server:**
 
   ```sh
   sudo apt install docker.io -y
   sudo usermod -aG docker jenkins
   sudo systemctl restart jenkins
   ```

2. **Install Git and Docker Plugins in Jenkins:**

   - Go to Jenkins Dashboard -> Manage Jenkins -> Manage Plugins.

    - Install Git and Docker plugins.

3. **Create a Jenkins Pipeline Job:**

    - Go to Jenkins Dashboard -> New Item.

    - Enter a name, select "Pipeline", and click "OK".

   - In the pipeline section, choose "Pipeline script from SCM".

    - Select "Git" and provide your repository URL and credentials.

4. **Define Pipeline in `Jenkinsfile`:**

    - Create a `Jenkinsfile` in your repository:

   ```groovy
     pipeline {
         agent any
         stages {
             stage('Build') {
                 steps {
                     script {
                         def app = docker.build("yourusername/your-app")
                     }
                 }
             }
             stage('Test') {
                 steps {
                     script {
                         docker.image("yourusername/your-app").inside {
                             sh 'npm test'
                         }
                     }
                 }
             }
             stage('Deploy') {
                 steps {
                     script {
                         docker.image("yourusername/your-app").run("-p 3000:3000")
                     }
                 }
             }
         }
     }
     ```

5. **Commit and Push `Jenkinsfile`:**
 
   ```sh
   git add Jenkinsfile
   git commit -m "Add Jenkinsfile"
   git push origin main
   ```

### Step 5: Execute the Pipeline

1. **Run the Pipeline:**

    - Go to Jenkins Dashboard -> your pipeline job -> Build Now.

    - Monitor the pipeline execution in the "Console Output".

### Step 6: Access the Deployed Application


- After a successful pipeline run, access your application using the public IP of your EC2 instance at `http://your-ec2-public-dns:3000`.

### Conclusion

This guide provides an end-to-end solution for setting up a CI/CD pipeline using AWS, GitHub, Jenkins, and Docker. 
You can further enhance the pipeline by adding more stages, such as automated testing, code quality checks, and more robust deployment strategies.
