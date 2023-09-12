pipeline {
    agent any
    stages {
        stage('packer-init'){
            steps{
                echo 'initializing Packer'
                sh '/usr/bin/packer init gcp-mi-v1.pkr.hcl'
            }           
        }
        stage('packer-valid'){
            steps{
                echo 'validating Packer'
                sh '/usr/bin/packer validate gcp-mi-v1.pkr.hcl'
            }           
        }
        stage('packer-build'){
            steps{
                withCredentials([file(credentialsId: 'gcp-credential', variable: 'GOOGLE_CREDENTIALS_JSON')]){
                    sh """\
                        echo '$GOOGLE_CREDENTIALS_JSON' > gcp-key.json
                        gcloud auth activate-service-account --key-file=gcp-key.json
                        echo 'Building Machine Image'
                        sh '/usr/bin/packer build gcp-mi-v1.pkr.hcl'
                    """
                }                
            }
        }
    }
}

