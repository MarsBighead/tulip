pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('Preparation') {
      steps {
        script {
          echo "Pull code from repository with credential id: ${GIT_CREDENTIALS_ID}"
          git([ branch: 'master', credentialsId: GIT_CREDENTIALS_ID, url: STAGE_KEYS_REPO])
        }

      }
    }

    stage('Build') {
      steps {
        script {
          echo "Build stage"
        }

      }
    }

    stage('Deploy') {
      steps {
        script {
          echo "${env.DEPLOY_ENV}"
          echo "Deploy stage"
        }

      }
    }

  }
  environment {
    STAGE_KEYS_REPO = 'git@github.com:MarsBighead/tulip.git'
    GIT_CREDENTIALS_ID = 'jenkins'
  }
}