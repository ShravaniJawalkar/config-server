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
                // Use the sshagent step to manage the SSH key securely in memory
                sshagent(credentials: ['ec2-ssh-key']) {
                    // Use a single bat block for both scp and ssh
                    bat '''
                        scp -o StrictHostKeyChecking=no target/config-server-0.0.1-SNAPSHOT.jar ^
                        ec2-user@ec2-43-205-203-27.ap-south-1.compute.amazonaws.com:/home/ec2-user/app/

                        ssh -T -o StrictHostKeyChecking=no ec2-user@ec2-43-205-203-27.ap-south-1.compute.amazonaws.com "pkill -f config-server-0.0.1-SNAPSHOT.jar || true"

                        ssh -T -o StrictHostKeyChecking=no ec2-user@ec2-43-205-203-27.ap-south-1.compute.amazonaws.com "java -jar /home/ec2-user/app/config-server-0.0.1-SNAPSHOT.jar &"
                    '''
                }
            }
        }
    }
}