pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_BACKEND_REGION = 'us-east-1'
    }
    stages {
        stage('Initialize') {
            steps {
                script {
                    echo "Using AWS Key: ${env.AWS_ACCESS_KEY_ID}"
                }
            }
        }
        stage('Git Download') {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/projectaws741/terraform-RDS-Jenkins.git'
                }
            }
        }
        stage('Terraform Init') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh """
                            terraform init \
                            -backend-config="region=${env.TF_BACKEND_REGION}"
                        """
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                     string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh """
                            terraform plan \
                            -var AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} \
                            -var AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} \
                            -var AWS_REGION=${env.TF_BACKEND_REGION}
                        """
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh """
                            terraform apply -auto-approve \
                            -var AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} \
                            -var AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} \
                            -var AWS_REGION=${env.TF_BACKEND_REGION}
                        """
                }
            }
        }
        stage('Post-Deployment Notifications') {
            steps {
                script {
                    echo "Deployment completed. Sending notifications..."
                    // Add Slack or email notifications
                }
            }
        }
    }
}
