pipeline {
    agent {
        label 'java-slave'
    }
    stages {
        stage ('git integrate') {
            steps{
                git url:'https://github.com/padmapriya-26/spring-petclinic.git' , branch: 'main'
            }
        }
        stage ('build with maven') {
            steps{
                sh 'mvn clean package -DskipTests'
            }
        }
    }
}
