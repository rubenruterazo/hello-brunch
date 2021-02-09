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
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
        stage('Security') {
            steps {

                sh 'trivy image --format json --output trivy-results.json hello-brunch'
                
            }
            post {
                always {
                    recordIssues(
                            enabledForFailure: true,
                            tools: [trivy( pattern: 'trivy-results.json')]
                    )
                }
            }
        }

    }
}
