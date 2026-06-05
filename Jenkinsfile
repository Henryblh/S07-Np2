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
                script
                {def status = currentBuild.currentResult
                                    mail to: "${env.NOTIFICATION_EMAIL}",
                                         subject: "Pipeline Status: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                                         body: "Pipeline finished with status: ${status}. See artifacts at ${env.BUILD_URL}"
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
