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
        stage('Security') {
            steps {
                sh 'trivi filesystem -f json -o trivi-fs.json .'
                sh 'trivy image --format json --output trivy-results.json hello-brunch'
                
            }
            post {
                always {
                    recordIssues(
                            enabledForFailure: true,
                            aggregatingResults:true,
                            tools: [trivy( pattern: 'trivy-*.json')]
                    )
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
        

    }
}
