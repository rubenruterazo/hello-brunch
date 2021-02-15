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
                        sh 'docker tag hello-brunch:${env.BUILD_NUMBER} 10.250.15.2:5050/root/hello-brunch'
                        sh 'docker push 10.250.15.2:5050/root/hello-brunch'
                }
            }
        }
        

    }
}
