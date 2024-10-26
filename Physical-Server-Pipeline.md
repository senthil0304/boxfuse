

    pipeline {
    agent any 

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    stages {
        stage("git clone") {
            steps {
                git branch: 'main', url: 'https://github.com/senthil0304/boxfuse.git'
            }
        }
        stage("build project") {
            steps {
                sh "mvn clean package"
            }
        }
        stage("deploy to tomcat") {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'tomcat_server_ssh_key', keyFileVariable: 'SSH_KEY')]) {
                    sh """
                        scp -i \$SSH_KEY -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/tomcatproject/target/hello-1.0.war ubuntu@65.2.167.13:/opt/tomcat/webapps/
                        ssh -i \$SSH_KEY -o StrictHostKeyChecking=no ubuntu@65.2.167.13 '/opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.sh'
                    """
                }
            }
        }
    }
    }
