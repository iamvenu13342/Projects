<h1>simple CI/CD pipeline project</h1>
Sure, let's create a complete CI/CD pipeline using AWS EC2, GitHub, and Jenkins. This project will include setting up a simple web application, configuring a GitHub repository, and setting up Jenkins to automate the build and deployment process.

### Step 1: Set up an AWS EC2 Instance

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

### Step 2: Install Jenkins on the EC2 Instance

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

4. **Open Jenkins Web Interface**:
   - Open your browser and navigate to `http://your-ec2-public-dns:8080`.
   - Retrieve the initial admin password:
     ```bash
     sudo cat /var/lib/jenkins/secrets/initialAdminPassword
     ```
   - Follow the instructions to set up Jenkins and install the suggested plugins.

### Step 3: Set up a GitHub Repository

1. **Create a GitHub Repository**:
   - Go to GitHub and create a new repository (e.g., `simple-ci-cd-project`).

2. **Clone the Repository to Your Local Machine**:
   ```bash
   git clone https://github.com/your-username/simple-ci-cd-project.git
   cd simple-ci-cd-project
   ```

3. **Add a Simple Web Application**:
   - Create a simple HTML file (`index.html`):
     ```html
     <!DOCTYPE html>
     <html>
     <head>
         <title>Simple CI/CD Project</title>
     </head>
     <body>
         <h1>Hello, World!</h1>
         <p>This is a simple CI/CD project.</p>
     </body>
     </html>
     ```

4. **Push Changes to GitHub**:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

### Step 4: Configure Jenkins for CI/CD

1. **Install Git Plugin in Jenkins**:
   - Go to "Manage Jenkins" > "Manage Plugins".
   - Install the "Git Plugin".

2. **Create a New Jenkins Job**:
   - Go to the Jenkins dashboard.
   - Click on "New Item", enter a name for your job (e.g., `simple-ci-cd-job`), select "Freestyle project", and click "OK".

3. **Configure the Job**:
   - Under "Source Code Management", select "Git" and enter your repository URL (e.g., `https://github.com/your-username/simple-ci-cd-project.git`).
   - If your repository is private, you'll need to add your GitHub credentials.

4. **Add a Build Step**:
   - In the "Build" section, click "Add build step" and select "Execute shell".
   - Enter a simple build script, for example:
     ```bash
     echo "Building the project..."
     mkdir -p /var/www/html
     cp index.html /var/www/html/
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

### Step 6: Set Up a Simple Web Server

1. **Install Apache**:
   ```bash
   sudo apt update
   sudo apt install apache2 -y
   ```

2. **Configure Apache to Serve the Web Application**:
   - Edit the Apache default site configuration file:
     ```bash
     sudo nano /etc/apache2/sites-available/000-default.conf
     ```
   - Change the `DocumentRoot` to `/var/www/html` if it's not already set:
     ```apache
     DocumentRoot /var/www/html
     ```
   - Save and close the file.

3. **Restart Apache**:
   ```bash
   sudo systemctl restart apache2
   ```

### Testing the CI/CD Pipeline

1. **Make a Change in the Repository**:
   - Edit the `index.html` file or any other file in your local repository.
   - Commit and push the changes to GitHub:
     ```bash
     git add .
     git commit -m "Updated index.html"
     git push origin main
     ```

2. **Check Jenkins**:
   - Go to your Jenkins dashboard.
   - Verify that a new build is triggered automatically by the webhook.

3. **Verify the Deployment**:
   - Open your browser and navigate to `http://your-ec2-public-dns`.
   - You should see your updated web application.

Congratulations! You've set up a full CI/CD pipeline using AWS EC2, GitHub, and Jenkins. Now, every time you push changes to your GitHub repository, Jenkins will automatically build the project, copy the files to the web server, and ensure your application is up-to-date.
