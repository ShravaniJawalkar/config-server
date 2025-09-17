pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/ShravaniJawalkar/config-server.git'
            }
        }

    stage('Build') {
            steps {
                bat 'mvnw.cmd clean package'
            }
        }



        stage('Deploy') {
            steps {
                // Placeholder for deployment logic (e.g., Docker or copying artifacts)
                echo 'Deploy Stage - Deployment can be added here!'
            }
        }
    }
}