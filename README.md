# devops-end-to-end-java1
**Maven + SonarQube + Docker + GCP Kubernetes CI/CD Pipeline 🚀**

---

## 🔧 Tech Stack
- **Java + Maven**: Build and manage dependencies for the Java application.  
- **SonarQube**: Perform static code analysis and ensure code quality.  
- **Jenkins**: Orchestrates the end-to-end CI/CD pipeline.  
- **Docker**: Containerizes the Java application for deployment.  
- **Docker Hub**: Stores and distributes Docker images.  
- **Google Cloud Platform (GKE)**: Deploy the containerized application to Kubernetes.  
- **Terraform (optional)**: Provision infrastructure for GKE clusters.  

---

## 🔄 CI/CD Workflow  
**Jenkinsfile Stages:**  
1. **Clone Git Repo**: Fetch the source code from GitHub.  
2. **Maven Build**: Compile the Java application and run tests.  
3. **SonarQube Analysis**: Perform static analysis for code quality.  
4. **Docker Build**: Build the Docker image for the application.  
5. **Push Docker Image**: Push the image to Docker Hub.  
6. **Authenticate to GCP**: Set up authentication for GCP services.  
7. **Update Kubernetes Deployment**: Modify the Kubernetes deployment YAML with the new Docker image.  
8. **Deploy to GKE**: Apply the Kubernetes manifest to deploy the application on GKE.  

---

## 🔐 Jenkins Credentials Required
- **sonar-token**: SonarQube access token for analysis.  
- **docker-hub**: Docker Hub username and password for pushing images.  
- **gcp-key**: GCP service account key for deploying to GKE.  

---

## ⚙️ How to Trigger the Pipeline
You can trigger the Jenkins pipeline manually or automatically via webhook on commit.

---

## 🎯 Outcome
- **Java Application**: Automatically built using Maven.  
- **Code Quality**: SonarQube analysis ensures code quality checks.  
- **Docker Image**: Containerized and pushed to Docker Hub.  
- **Deployment**: Application is deployed to a Kubernetes cluster on GKE.  

---

## 🛠️ Future Improvements
- Integrate **Quality Gate** for SonarQube to automatically fail builds based on quality issues.  
- Add **Slack notifications** for build success or failure.  
- Migrate from raw Kubernetes YAML to using **Helm** for easier management.  
- Full **Terraform** integration for GKE cluster provisioning.  

---

*A seamless DevOps pipeline that automates building, testing, and deploying applications with efficiency and scalability.*  
