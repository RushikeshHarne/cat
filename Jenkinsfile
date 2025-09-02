pipeline {
  agent any

  environment {
    IMAGE_NAME = "harnempire/testing"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build (docker-compose)') {
      steps {
        // Build images declared in docker-compose.yml
        sh 'docker-compose up --build -d'
      }
    }

    stage('Tag & Push to Docker Hub') {
    steps {
        script {
            // get short commit sha for tagging
            def SHORT_SHA = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
            echo "Commit SHA: ${SHORT_SHA}"

            withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    # tag dynamically with SHA
                    docker tag harnempire/cat:v2 ${IMAGE_NAME}:${SHORT_SHA}
                    docker push ${IMAGE_NAME}:${SHORT_SHA}

                    # optional: also push as latest
                    # docker tag harnempire/cat:v2 ${IMAGE_NAME}:latest
                    # docker push ${IMAGE_NAME}:latest
                """
            }
        }
    }
}


    stage('Cleanup') {
      steps {
        sh 'docker logout || true'
      }
    }
  }

  post {
    success {
      echo "Build & push completed. doned"
    }
    failure {
      echo "Build failed - check console output."
    }
  }
}
