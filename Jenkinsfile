pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "mluduenia/simple-nodejs"
    }

    stages {
        stage('Authenticate with Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh "echo ${DOCKER_HUB_PASSWORD} | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Pull latest image for caching
                sh "docker pull ${DOCKER_IMAGE_NAME}:latest || true"
         
                // Build the image using cache from the latest image
                sh "docker build --cache-from=${DOCKER_IMAGE_NAME}:latest -t ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ."
            }
        }

        stage('Test Security Scan') {
            steps {
                script {
                    // Run the container and execute tests inside it
                    sh "docker run --rm ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} npm test"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the newly built Docker image
                    sh "docker push ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
                    
                    // If the build is from the main branch, tag the image as 'latest' and push it
                    if (env.BRANCH_NAME == 'main') {
                        sh "docker tag ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER} ${DOCKER_IMAGE_NAME}:latest"
                        sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                try {
                    // Cleanup: Remove the built Docker image from the local machine
                    sh "docker rmi ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
                } catch (Exception e) {
                    echo 'Failed to remove Docker image.'
                }
            }
        }

        success {
            echo "✅ Build ${env.BUILD_NUMBER} succeeded!"
        }
        
        failure {
            echo "❌ Build ${env.BUILD_NUMBER} failed!"
        }
    }
}
