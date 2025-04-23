pipeline {
    agent any
    environment {
        SONAR_URL = 'http://192.168.2.174:9000'  // SonarQube server URL
        SONAR_TOKEN = credentials('sonar-token')  // Jenkins credentials for SonarQube token
        IMAGE_TAG = "java_calculator"  // Image tag for Docker
        DOCKER_HUB_USER = credentials('dockerhub')  // Docker Hub credentials
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-key')  // Google Cloud credentials for GCP
        DEPLOY_YAML = 'kubernetes/deployment.yaml'  // Path to Kubernetes deployment YAML
        CLUSTER_NAME = 'cluster-1'  // GKE Cluster name
        ZONE = 'us-central1-c'  // GKE Cluster zone
        IMAGE_NAME = "java_calculator"  // Docker image name
        DOCKER_REPO = "saicharan12121/java_calculator"  // Docker repository
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Saicharan619/devops-end-to-end-java1.git'
            }
        }
    stage( "maven" ){
        steps{
            sh """
            pwd
            ls
            mvn clean package
            
            """
        }
    }

     
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh '''
                   mvn clean verify sonar:sonar \
                  -Dsonar.projectKey=java-project2 \
                  -Dsonar.projectName='java-project2' \
                  -Dsonar.host.url=http://192.168.2.174:9000 \
                  -Dsonar.token=${SONAR_TOKEN}
                   
                    '''
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_REPO}:${BUILD_NUMBER}
                '''
            }
        }

        stage("Docker Login & Push") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                    echo $PASSWORD | docker login -u $USERNAME --password-stdin
                    docker push ${DOCKER_REPO}:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage("Google Cloud Login") {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                    gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                    gcloud container clusters get-credentials ${CLUSTER_NAME} --zone ${ZONE} --project saicharan-452306
                    '''
                }
            }
        }

        stage('Update Deployment Files') {
            steps {
                sh '''
                sed -i "s|image: .*|image: ${DOCKER_REPO}:${BUILD_NUMBER}|" $DEPLOY_YAML
                '''
            }
        }

        stage('Deploy to Cluster') {
            steps {
                sh '''
                kubectl apply -f $DEPLOY_YAML
                kubectl apply -f kubernetes/service.yaml
                echo "Waiting for LoadBalancer IP to be assigned..."
                sleep 50
                kubectl get svc
                sleep 20
                '''
            }
        }

        stage('Get Service') {
            steps {
                sh '''
                echo "Fetching final LoadBalancer IP..."
                kubectl get svc
                '''
            }
        }
    }

    post {
        success {
            echo "🎉 Application successfully deployed in GKE with Docker and SonarQube integration!"
        }
        failure {
            echo "❌ Build failed. Check console output for more info."
        }
    }
}
