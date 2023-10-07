pipeline{
    agent any
    stages {
        stage('Terraform-init') {
            steps {
                echo 'initializing Terraform'
                sh 'terraform init'
            }           
        }
    }
    stage('Terraform Plan'){
        steps {
            script {
                sh 'terraform plan'
            }
        }
    }
    
}
