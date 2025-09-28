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
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'PRIVATE_KEY_PATH')]) {
                        bat '''
                        rem Restrict permissions on the private key file
                        icacls "%PRIVATE_KEY_PATH%" /inheritance:r /grant:r "SYSTEM:F"

                        rem Ensure the remote directory has the correct permissions
                        ssh -i "%PRIVATE_KEY_PATH%" -T -o StrictHostKeyChecking=no ec2-user@ec2-35-154-38-224.ap-south-1.compute.amazonaws.com "sudo chown -R ec2-user:ec2-user /home/ec2-user/app"

                        rem Use ssh to stop running application
                        ssh -i "%PRIVATE_KEY_PATH%" -T -o StrictHostKeyChecking=no ec2-user@ec2-35-154-38-224.ap-south-1.compute.amazonaws.com "pkill -f config-server-0.0.1-SNAPSHOT.jar || true"

                        rem Use scp to copy the file
                        scp -i "%PRIVATE_KEY_PATH%" -o StrictHostKeyChecking=no target/config-server-0.0.1-SNAPSHOT.jar ec2-user@ec2-35-154-38-224.ap-south-1.compute.amazonaws.com:/home/ec2-user/app/
                        '''
                    }
                }
            }
        }
    }
}