pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = "/var/lib/jenkins/key.json"
    }
    stages {
        stage('Checkout Code') {
            steps {
                   cleanWs()
                   git branch: 'main', url: 'https://github.com/padmapriya-26/spring-petclinic.git'
                }
            }
        stage('create infra') {
            steps {
                dir('terraform') {
                    sh '''
                    terraform init
                    terraform validate
                    terraform plan
                    terraform apply --auto-approve
                    terraform destroy --auto-approve
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
                 mvn clean verify sonar:sonar \
                 -Dsonar.projectKey=sonar \
                 -Dsonar.host.url=http://136.111.30.31:9000 \
                 -Dsonar.login=sqp_a5d6b0a58b8f67ef698445113470bb2b49323405
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
