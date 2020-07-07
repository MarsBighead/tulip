
/*
properties([
  parameters([
    string(name: 'DEPLOY_ENV', defaultValue: 'dev', description: 'The target environment', )
   ])
])
*/
pipeline {
    agent {
        label 'capricorn-worker'
    }
    environment{
        STAGE_KEYS_REPO = "git@github.com:MarsBighead/tulip.git"
        GIT_CREDENTIALS_ID = "jenkins"
    }
    stages {
        stage('Preparation') { // for display purposes
            // Get some code from a GitHub repository
            steps {
                script {
                    echo "Pull code from repository with credential id: ${GIT_CREDENTIALS_ID}"
                    git([ branch: 'master', credentialsId: GIT_CREDENTIALS_ID, url: STAGE_KEYS_REPO])
                 }
            }
        }
        stage('Build') {
            // Run Capricorn build process
            steps {
                script {
                    echo "Build stage"
                    //sh "/bin/bash  scripts/build.sh --env ${env.DEPLOY_ENV}"
                }
            }
        }
        stage('Deploy') {
            // Deploy Capricorn to targe host
             steps {
                script {
                    echo "${env.DEPLOY_ENV}"
                    echo "Deploy stage"
                    //sh "/bin/bash  scripts/deploy.sh --env ${env.DEPLOY_ENV}"
                }
            }
        }
    }
}
