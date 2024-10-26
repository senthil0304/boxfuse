Here's my pipeline 🌟🎉
    
    pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    stages {
        stage("Git Clone") {
            steps {
                git branch: 'main', credentialsId: 'git-cred', url: 'https://github.com/senthil0304/boxfuse.git'
            }
        }
        stage("Maven Project") {
            steps {
                sh "mvn clean package"
                sh "cp target/hello-1.0.war ."
            }
        }
        stage("Docker Image Building and Pushing To Docker Hub") {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh 'docker build -t senthilkumar03/jenkinrepo:30 .'
                        sh 'docker push senthilkumar03/jenkinrepo:30'
                    }
                }
            }
        }
    }
    }
