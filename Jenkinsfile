pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = "/var/lib/jenkins/key.json"
    }
    stages {
        stage('Checkout Code') {
            steps {
               cleanWs()
               sh '''
                 sudo apt-get update
                 sudo apt-get install git -y
                 '''
                git branch: 'main', url: 'https://github.com/padmapriya-26/spring-petclinic.git'
            }
        }

        stage('create infra') {
            steps {
                cleanWs()
                dir('terraform') {
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
               mvn org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
               -Dsonar.projectKey=spring-petclinic \
               -Dsonar.host.url=http://<SONAR_IP>:9000 \
               -Dsonar.login=<SONAR_TOKEN>
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
