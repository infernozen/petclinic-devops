pipeline {
    agent any
    stages {
        stage('packer-valid'){
            steps{
                echo 'validating Packer'
                sh '/usr/bin/packer validate gcp-mi-v1.pkr.hcl'
            }           
        }
        stage('packer-build'){
            steps{
                echo 'building image'
                sh '/usr/bin/packer build gcp-mi-v1.pkr.hcl'
            }
        }
    }
}

