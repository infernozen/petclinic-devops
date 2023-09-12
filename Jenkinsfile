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
                        def googleCredentials = readFile('/var/jenkins_home/secrets/your-credential-id')
                        writeFile file: 'gcp-key.json', text: googleCredentials
                        sh '''
                            ls -l gcp-key.json
                            cat gcp-key.json
                            gcloud auth activate-service-account --key-file=gcp-key.json
                            echo 'Building Machine Image'
                            sh '/usr/bin/packer build gcp-mi-v1.pkr.hcl'
                        '''
                    }
                }
            }
        }
    }
}
