<h1>simple CI/CD pipeline project</h1>
Sure! Here's a step-by-step guide to create a simple CI/CD pipeline project using AWS EC2, GitHub, and Jenkins. This guide assumes you have basic knowledge of these tools and have the necessary accounts set up.

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

### Step 3: Set up GitHub Repository

1. **Create a GitHub Repository**:
   - Go to GitHub and create a new repository (e.g., `simple-ci-cd`).

2. **Clone the Repository to Your Local Machine**:
   ```bash
   git clone https://github.com/your-username/simple-ci-cd.git
   cd simple-ci-cd
   ```

3. **Add a Simple Application**:
   - Create a simple application, for example, a basic HTML file (`index.html`).

4. **Push Changes to GitHub**:
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

### Step 4: Configure Jenkins for CI/CD

1. **Create a New Jenkins Job**:
   - Go to the Jenkins dashboard.
   - Click on "New Item", enter a name for your job, select "Freestyle project", and click "OK".

2. **Configure the Job**:
   - Under "Source Code Management", select "Git" and enter your repository URL (e.g., `https://github.com/your-username/simple-ci-cd.git`).
   - If your repository is private, you'll need to add your GitHub credentials.

3. **Add a Build Step**:
   - In the "Build" section, click "Add build step" and select "Execute shell".
   - Enter a simple build script, for example:
     ```bash
     echo "Building the project..."
     ```

4. **Add a Post-build Action**:
   - In the "Post-build Actions" section, click "Add post-build action" and select "Archive the artifacts".
   - Enter the files to archive, for example, `*.html`.

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

Congratulations! You've set up a simple CI/CD pipeline using AWS EC2, GitHub, and Jenkins. Now, every time you push changes to your GitHub repository, Jenkins will automatically build and archive the artifacts.
