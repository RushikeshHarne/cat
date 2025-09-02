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
        sh 'docker-compose -f docker-compose.yml build --parallel'
      }
    }

    stage('Tag & Push to Docker Hub') {
      steps {
        script {
          // get short commit sha for tagging
          SHORT_SHA = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
        }

        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh '''
            # login using token (password)
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin


            # optionally add a tag by commit sha (compose already built :latest)
            docker tag harnempire/cat:v2 ${IMAGE_NAME}:${SHORT_SHA} || true

            # push both latest and sha tag (docker-compose push will push 'image' names too)
            docker push ${IMAGE_NAME}:${SHORT_SHA}
          '''
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
      echo "Build & push completed."
    }
    failure {
      echo "Build failed - check console output."
    }
  }
}
