# Jenkins Pipeline for Node.js Docker Application

This repository contains a **Jenkins pipeline** for building, testing, and pushing a Dockerized Node.js application. The pipeline automates the following processes:

- **Linting & Security Scanning**
- **Building a Docker Image**
- **Running Tests**
- **Pushing the Image to Docker Hub**
- **Cleanup of Unused Images**

## **Pipeline Stages**

### **1. Build Docker Image**
- Authenticates with **Docker Hub** using Jenkins credentials.
- Builds a Docker image using the current **build number** as a tag.

### **2. Lint & Security Scan**
- Installs dependencies.
- Runs **ESLint** for code quality checks.
- Uses **Trivy** to scan the Docker image for vulnerabilities.

### **3. Test**
- Runs the **Node.js application tests** inside a Docker container.

### **4. Push Docker Image**
- Pushes the image to **Docker Hub**.
- If the build is on the `main` branch, tags the image as `latest` and pushes it.

### **5. Cleanup**
- Removes the built Docker image from the local machine to save space.

---

## **Jenkinsfile Configuration**

### **Environment Variables**
| Variable | Description |
|----------|-------------|
| `DOCKER_IMAGE_NAME` | Docker image name (e.g., `franciscoboll/simple-nodejs`) |
| `BUILD_NUMBER` | Jenkins build number used as the image tag |
| `BRANCH_NAME` | Name of the branch triggering the build |

### **Jenkins Credentials**
Ensure you have a **Docker Hub credential** stored in Jenkins:
- **ID:** `docker-hub-credentials`
- **Username:** Your Docker Hub username
- **Password:** Your Docker Hub password

---

## **Requirements**
- **Jenkins** installed with the following plugins:
  - **Pipeline Plugin**
  - **Git Plugin**
  - **Credentials Binding Plugin**
- **Docker** installed on the Jenkins agent.
- **Node.js** dependencies defined in `package.json`.

---

## **How to Use**
1. Set up Jenkins and create a new pipeline.
2. Add your repository URL and select the branch.
3. Ensure Jenkins has access to your **Docker Hub credentials**.
4. Run the pipeline and monitor the stages.

---

## **Future Enhancements**
- Add **Kubernetes deployment** after pushing the image.
- Integrate **Slack notifications** for build status.
- Implement **conditional security checks** to fail on high vulnerabilities.

---

For any issues or improvements, feel free to contribute! 🚀

