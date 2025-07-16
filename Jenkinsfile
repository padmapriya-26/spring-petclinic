pipeline {
    agent {
        label 'jenkins_slave'
    }
    tools {
        maven 'maven-3'
    }
    stages {
        stage ('build')
        echo "spring petclinic"
        sh "mvn --version"
    }
}
