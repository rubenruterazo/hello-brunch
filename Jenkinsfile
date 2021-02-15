#!/usr/bin/env groovy
pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
        stage('Build') {
            steps {
                //git url:'https://github.com/rubenruterazo/hello-brunch.git', branch:'main'
                sh 'docker-compose build'
            }
        }
        
        stage('Publish') {
            steps {
                withDockerRegistry([credentialsId:"gitlab-registry", url:"http://10.250.15.2:5050"]){
                        sh 'echo ${BUILD_NUMBER}'
                        sh 'docker tag hello-brunch:latest 10.250.15.2:5050/root/hello-brunch:BUILD-1.${BUILD_NUMBER}'
                        sh 'docker push 10.250.15.2:5050/root/hello-brunch:BUILD-1.${BUILD_NUMBER}'
                        
                }
            }
            post{
                success{
                    sshagent(credentials:['ssh-key']){
                        sh 'git remote'
                        sh 'git tag BUILD-1.${BUILD_NUMBER}'
                        sh 'git push -u origin --tags'
                    }
                }
                  
            }
        }
        stage('Remote deploy'){
            steps{
                sh 'ls'
                sshagent(['deploy-key']) {
                    sh 'ssh-add -l'
                    sh 'ssh -t -o "StrictHostKeyChecking no" deploy@10.250.15.2 'docker-compose pull && docker-compose up -d''
                    sh 'ls'
                    sh 'docker pull 10.250.15.2:5050/root/hello-brunch:latest'
                }
            }
        }
        

    }
}

