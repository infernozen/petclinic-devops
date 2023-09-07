pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                git credentialsId: 'git-credentials', url: 'https://github.com/infernozen/packer.git'
            }
        }
    }
}
