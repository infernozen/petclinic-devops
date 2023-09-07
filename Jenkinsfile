pipeline {
    agent any
    stages {
        stage('Git-clone') {
            steps {
                git branch: 'main', credentialsId: 'git-credentials', url: 'https://github.com/infernozen/packer.git'
            }
        }
    }
}
