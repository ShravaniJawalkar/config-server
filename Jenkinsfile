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

        stage('Debug SSH Agent Environment') {
                    steps {
                        script {
                            withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'PRIVATE_KEY_PATH')]) {
                                bat '''
                                     echo "Private key available at: %PRIVATE_KEY_PATH%"
                                     rem Now you can use this key with your SSH client
                                     ssh -i "%PRIVATE_KEY_PATH%" ec2-user@ec2-43-205-203-27.ap-south-1.compute.amazonaws.com
                                '''
                            }
                        }
                    }
                }

               stage('Deploy') {
                   steps {
                       withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'PRIVATE_KEY_PATH')]) {
                           bat '''
                               scp -i "%PRIVATE_KEY_PATH%" -o StrictHostKeyChecking=no target/config-server-0.0.1-SNAPSHOT.jar ^
                               ec2-user@ec2-43-205-203-27.ap-south-1.compute.amazonaws.com:/home/ec2-user/app/
                           '''
                       }
                   }
               }

        stage('Run App') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'PRIVATE_KEY_PATH')]) {
                    bat '''
                    ssh -o StrictHostKeyChecking=no ec2-user@ec2-43-205-203-27.ap-south-1.compute.amazonaws.com <<EOF
                    pkill -f config-server-0.0.1-SNAPSHOT.jar || true
                    java -jar /home/ec2-user/app/config-server-0.0.1-SNAPSHOT.jar &
                    EOF
                    '''
                }
            }
        }

    }
}