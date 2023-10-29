pipeline {
    agent any
    stages {
        stage('packer-init') {
            steps {
                echo 'initializing Packer'
                sh '/usr/bin/packer init gcp-mi-v1.pkr.hcl'
            }           
        }
        stage('packer-valid') {
            steps {
                echo 'validating Packer'
                sh '/usr/bin/packer validate gcp-mi-v1.pkr.hcl'
            }           
        }
        stage('packer-build') {
            steps {
                withCredentials([file(credentialsId: 'gcp-credential', variable: 'GOOGLE_CREDENTIALS_JSON')]) {
                    script {
                        def googleCredentials = readFile GOOGLE_CREDENTIALS_JSON
                        writeFile file: 'gcp-key.json', text: googleCredentials
                        sh '''
                            mv gcp-key.json $HOME/.config/gcloud/application_default_credentials.json
                            echo 'Building Machine Image'
                            /usr/bin/packer build gcp-mi-v1.pkr.hcl
                        '''
                    }
                }
            }
        }
    }
}
