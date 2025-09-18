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
                sshagent(credentials: ['ec2-ssh-key']) {
                            sh '''
                            scp -o StrictHostKeyChecking=no -i ~/.ssh/config-server.pem \
                                target/config-server-0.0.1-SNAPSHOT.jar ec2-65-2-9-178.ap-south-1.compute.amazonaws.com:/home/ec2-user/app/
                            '''
                        }
                echo 'Deploy Stage - Deployment can be added here!'
            }
        }

        stage('Run App') {
            steps {
                sshagent(credentials: ['ec2-ssh-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ec2-65-2-9-178.ap-south-1.compute.amazonaws.com <<EOF
                    pkill -f config-server-0.0.1-SNAPSHOT.jar || true
                    java -jar /home/ec2-user/app/config-server-0.0.1-SNAPSHOT.jar &
                    EOF
                    '''
                }
            }
        }

    }
}