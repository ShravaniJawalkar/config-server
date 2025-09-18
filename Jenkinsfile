pipeline {
    agent any

    stages {
       stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/ShravaniJawalkar/config-server.git'
            }
        }
stage('Test Direct SSH Connection') {
    steps {
        powershell '''
            ssh -o StrictHostKeyChecking=no -i C:/Users/Shravani_Jawalkar/Downloads/config-server1.pem ec2-user@ec2-43-205-212-42.ap-south-1.compute.amazonaws.com echo "Connection successful"
        '''
    }
}
    stage('Build') {
            steps {
                bat 'mvnw.cmd clean package'
            }
        }

//         stage('Debug SSH Agent Environment') {
//             steps {
//                 script {
//                                     try {
//                                         sshagent(credentials: ['ec2-ssh-key']) {
// //                                             sh '''
// //                                                  echo "Debugging SSH Agent Environment..."
// //                                                  echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
// //                                                  echo "SSH_AGENT_PID=$SSH_AGENT_PID"
// //                                                  ls -l $SSH_AUTH_SOCK || echo "Socket file missing!"
// //                                                  env | grep SSH || echo "No SSH-related variables found"
// //                                             '''
// //                                         }
//                                     } catch (Exception e) {
//                                         echo "SSH Agent initialization failed: ${e}"
//                                         error("Please check your SSH credentials or SSH Agent setup!")
//                                     }
//                 }
//             }
//         }

//         stage('Deploy') {
//             steps {
//                 // Placeholder for deployment logic (e.g., Docker or copying artifacts)
//                sshagent(credentials: ['ec2-ssh-key']) {
//                    sh '''
//                        scp -o StrictHostKeyChecking=no target/config-server-0.0.1-SNAPSHOT.jar \
//                        ec2-user@ec2-65-2-9-178.ap-south-1.compute.amazonaws.com:/home/ec2-user/app/
//                    '''
//                }
//             }
//         }
//
//         stage('Run App') {
//             steps {
//                 sshagent(credentials: ['ec2-ssh-key']) {
//                     sh '''
//                     ssh -o StrictHostKeyChecking=no ec2-65-2-9-178.ap-south-1.compute.amazonaws.com <<EOF
//                     pkill -f config-server-0.0.1-SNAPSHOT.jar || true
//                     java -jar /home/ec2-user/app/config-server-0.0.1-SNAPSHOT.jar &
//                     EOF
//                     '''
//                 }
//             }
//         }

    }
}