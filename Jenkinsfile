
pipeline {
    agent any

    environment {
        REGISTRY_CREDENTIALS = 'dockerhub-credentials-id'    // Jenkins credentials ID
        DOCKER_IMAGE = 'your-dockerhub-username/jenkins-cicd-demo'
        APP_VERSION = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
        STAGING_HOST = 'staging.example.local'
        STAGING_USER = 'ubuntu'
        PROD_HOST    = 'prod.example.local'
        PROD_USER    = 'ubuntu'
    }

    options {
        timestamps()
        ansiColor('xterm')
    }

    triggers {
        // Optional: poll SCM or configure webhook in Jenkins UI
        // pollSCM('H/5 * * * *')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies & Test') {
            steps {
                dir('app') {
                    sh """
                        python -m venv venv
                        . venv/bin/activate
                        pip install --no-cache-dir -r requirements.txt
                        pytest
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t ${DOCKER_IMAGE}:${APP_VERSION} .
                        docker tag ${DOCKER_IMAGE}:${APP_VERSION} ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
                        docker push ${DOCKER_IMAGE}:${APP_VERSION}
                        docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy to Staging') {
            when {
                anyOf {
                    branch 'main'
                    branch 'master'
                    branch 'develop'
                }
            }
            steps {
                sh """
                    STAGING_HOST=${STAGING_HOST} \
                    STAGING_USER=${STAGING_USER} \
                    APP_VERSION=${APP_VERSION} \
                    ./scripts/deploy_staging.sh
                """
            }
        }

        stage('Approval for Production') {
            when {
                branch 'main'
            }
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    input message: 'Deploy to PRODUCTION?', ok: 'Deploy'
                }
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                sh """
                    PROD_HOST=${PROD_HOST} \
                    PROD_USER=${PROD_USER} \
                    APP_VERSION=${APP_VERSION} \
                    ./scripts/deploy_prod.sh
                """
            }
        }
    }

    post {
        always {
            echo "Build finished: ${currentBuild.currentResult}"
        }
        failure {
            echo "Build failed!"
        }
    }
}

