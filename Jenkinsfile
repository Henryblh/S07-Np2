pipeline {
    agent any

    environment {
        // Puxando a variável do Docker Compose
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
                // Roda os testes e gera os relatórios
                sh 'mvn clean test jacoco:report'
            }
            post {
                always {
                    // Lê o resultado dos testes
                    junit 'target/surefire-reports/*.xml'
                    // CORREÇÃO: Salva a pasta INTEIRA do relatório Jacoco
                    archiveArtifacts artifacts: 'target/site/jacoco/**/*', fingerprint: true
                }
            }
        }

        stage('Build & Package') {
            steps {
                // Empacota o .jar
                sh 'mvn package -DskipTests'
                // Salva o .jar gerado como artefato
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }

        stage('Notify Email') {
            steps {
                // CORREÇÃO: Usa exclusivamente o script do seu colega, nada de plugins visuais!
                script {
                    export JOB_STATUS="SUCCESS"
                    // Dá permissão de execução e roda o script
                    sh 'chmod +x ./jenkins/send_notification.sh'
                    sh './jenkins/send_notification.sh'
                }
            }
        }
    }

    post {
        failure {
            // Se o pipeline falhar antes de chegar no estágio de e-mail, ele avisa também
            script {
                export JOB_STATUS="FAILED"
                sh 'chmod +x ./jenkins/send_notification.sh'
                sh './jenkins/send_notification.sh'
            }
        }
    }
}
