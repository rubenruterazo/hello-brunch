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
                        sh 'docker tag hello-brunch:latest 10.250.15.2:5050/root/hello-brunch:latest'
                        sh 'docker push 10.250.15.2:5050/root/hello-brunch:latest'

                        
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
                sshagent(['deploy-key']) {
                    sh 'ssh -t -o "StrictHostKeyChecking no" deploy@10.250.15.2'
                    sh 'docker-compose pull && docker-compose up -d'
                }
            }
        }
        

    }
}

