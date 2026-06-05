pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "nicholasnkl/petclinic-s07"
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
                    archiveArtifacts artifacts: 'target/site/jacoco/index.html', fingerprint: true
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
                script {
                sh "JOB_STATUS=${currentBuild.currentResult} /workspace/jenkins/send_notification.sh"
                }
            }
        }
    }

    post {
        failure {
            script {
                export JOB_STATUS="FAILED"
                sh '/workspace/jenkins/send_notification.sh'
            }
        }
    }
}
