#  Write a pipeline that pushes the Java artifact to a bucket and builds a Docker image using the artifact retrieved from the bucket.
    
    
    pipeline {
    agent {
        label "build-agent"
    }

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = "/var/lib/jenkins/key.json"
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
            agent {
                    label "build-agent"
                }
            steps {
                sh '''
                mvn clean package -DskipTests
                '''
            }
        }

        /* ---------------- UPLOAD TO BUCKET ---------------- */
        stage('Upload Artifact to Bucket') {
            agent {
                    label "build-agent"
                }
            steps {
                sh '''
                gsutil cp target/spring-petclinic-3.5.0-SNAPSHOT.jar gs://java-artifact-bucket/app.jar

                '''
            }
        }

        /* ---------------- DOWNLOAD FROM BUCKET ---------------- */
        stage('Download Artifact from Bucket') {
            agent {
                    label "build-agent"
                }
            steps {
                sh '''
                rm -f app.jar
                gsutil cp ${BUCKET_NAME}/app.jar .
                '''
            }
        }

        /* ---------------- BUILD DOCKER IMAGE ---------------- */
        stage('Build Docker Image') {
            agent {
                    label "docker-agent"
                }
            steps {
                sh '''
                docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        /* ---------------- OPTIONAL: RUN CONTAINER ---------------- */
        stage('Run Docker Container') {
            agent {
                    label "docker-agent"
                }
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
