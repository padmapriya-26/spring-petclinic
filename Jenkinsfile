pipeline {

    agent none

    environment {
        APP_NAME = "java-app"
        IMAGE_TAG = "v1"
        DOCKER_IMAGE = "${APP_NAME}:${IMAGE_TAG}"
        SONARQUBE_ENV = "sonarqube"
    }

    stages {

        stage('Clone Code') {
            agent { label 'build-agent' }
            steps {
                git branch: 'main',
                    url: 'https://github.com/padmapriya-26/spring-petclinic.git'
            }
        }

        stage('Build Artifact') {
            agent { label 'build-agent' }
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Code Quality - SonarQube') {
            agent { label 'build-agent' }
            steps {
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh '''
                      mvn sonar:sonar \
                      -Dsonar.projectKey=java-app \
                      -Dsonar.projectName=java-app
                    '''
                }
            }
        }

        stage('Archive Artifact') {
            agent { label 'build-agent' }
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Copy Artifact to Docker VM') {
            agent { label 'build-agent' }
            steps {
                sh '''
                scp -o StrictHostKeyChecking=no \
                target/*.jar sony2@34.170.135.185:/home/sony2/app.jar
                '''
            }
        }

        stage('Build Docker Image') {
            agent { label 'docker-agent' }
            steps {
                sh '''
                docker build -t ${DOCKER_IMAGE} .
                '''
            }
        }

        stage('Run Docker Container') {
            agent { label 'docker-agent' }
            steps {
                sh '''
                docker run -d -p 8080:8080 ${DOCKER_IMAGE}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}
