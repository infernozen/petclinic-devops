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
    
<<<<<<< HEAD
}
=======
}
>>>>>>> 34395f082c5f419d72e4a19260cd5bbe5b4c89a4
