pipeline {
    agent {
        label "build-agent"
    }

    environment {
        BUCKET_NAME = "gs://java-artifact-bucket"
        APP_NAME = "spring-petclinic"
        IMAGE_TAG = "v1"
        IMAGE_NAME = "petclinic:${IMAGE_TAG}"
    }

    stages {

        /* ---------------- CHECKOUT ---------------- */
        stage('Checkout Code') {
            steps {
                cleanWs()
                git branch: 'main',
                    url: 'https://github.com/padmapriya-26/spring-petclinic.git'
            }
        }

        /* ---------------- BUILD JAR ---------------- */
        stage('Build Java Artifact') {
            steps {
                sh '''
                mvn clean package -DskipTests
                '''
            }
        }

        /* ---------------- UPLOAD TO BUCKET ---------------- */
        stage('Upload Artifact to Bucket') {
            steps {
                sh '''
                gsutil cp target/*.jar ${BUCKET_NAME}/app.jar
                '''
            }
        }

        /* ---------------- DOWNLOAD FROM BUCKET ---------------- */
        stage('Download Artifact from Bucket') {
            steps {
                sh '''
                rm -f app.jar
                gsutil cp ${BUCKET_NAME}/app.jar .
                '''
            }
        }

        /* ---------------- BUILD DOCKER IMAGE ---------------- */
        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        /* ---------------- OPTIONAL: RUN CONTAINER ---------------- */
        stage('Run Docker Container') {
            steps {
                sh '''
                docker rm -f petclinic || true
                docker run -d --name petclinic -p 8080:8080 ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Artifact pushed to bucket & Docker image built successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}
