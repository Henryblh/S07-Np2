pipeline {
    agent any

    environment {
        NOTIFICATION_EMAIL = "${env.NOTIFICATION_EMAIL}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test & Coverage') {
            steps {
                sh 'mvn clean test jacoco:report'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                    archiveArtifacts artifacts: 'target/site/jacoco/**/*', fingerprint: true
                }
            }
        }

        stage('Build & Package') {
            steps {
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Notify Email') {
            steps {
                // Forma correta de passar a variável para o Shell no Jenkins
                withEnv(['JOB_STATUS=SUCCESS']) {
                    sh 'chmod +x ./jenkins/send_notification.sh'
                    sh './jenkins/send_notification.sh'
                }
            }
        }
    }

    post {
        failure {
            // E fazemos o mesmo para caso de falha
            withEnv(['JOB_STATUS=FAILED']) {
                sh 'chmod +x ./jenkins/send_notification.sh'
                sh './jenkins/send_notification.sh'
            }
        }
    }
}
