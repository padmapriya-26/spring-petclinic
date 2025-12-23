pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = "/var/lib/jenkins/key.json"
    }
    stages {
        stage('checkout') {
            steps{
                cleanWs()
                sh "git clone https://github.com/spring-projects/spring-petclinic.git"
            }
        }
        stage('create infra') {
            steps {
                dir("spring-petclinic/terraform"){
                    sh '''
                 terraform init
                 terraform validate
                 terraform plan
                 terraform apply --auto-approve
                 '''
                }
        
            }
        }
        stage('build the artifact') {
            steps {
                sh '''
                rm -rf spring-petclinic
                git clone https://github.com/padmapriya-26/spring-petclinic.git
                cd spring-petclinic
                mvn clean package -DskipTests
                '''
            }
        }
        stage('code quality') {
            steps {
               sh '''
               cd spring-petclinic
               mvn sonar:sonar
               '''
            }
        }
        stage('upload artifact to bucket') {
            steps {
               sh '''
               gsutil cp spring-petclinic/target/*.jar gs://java-artifact-bucket/
               '''
            }
        }

    }
}
