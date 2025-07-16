pipeline {
    agent any
    tools {
        maven 'maven-3.8.9'
    }
    stages {
        stage('Build') {
            steps {
                echo "this is my spring pipeline"
                sh "mvn --version"
            }
        }
    }
}
