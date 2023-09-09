pipeline {
    agent any
    stages {
        stage('packer-init'){
            steps{
                echo 'Initializing Packer'
                sh '/usr/bin/packer init gcp-mi-v1.pkr.hcl'
            }           
        }
    }
}

