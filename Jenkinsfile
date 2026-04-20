pipeline{

    agent any

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'uat', 'prod'],
            description: 'Select the environment to deploy'
        )
        choice(
            name: 'Action',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Select the Terraform action to perform'
        )
        string(
            name: 'Branch',
            defaultValue: 'main',
            description: 'Enter the Git branch to deploy'
        )
    }

    stages {
        stage('checkout'){
            steps{
                checkout scmGit(
                    branches: [[name: "*/${params.Branch}"]]
                    userRemoteConfigs: [[url: 'https://github.com/pratikzende882002-hash/Terraform-root-main.git']]
                )
            }
        }

    }

    stages{
        stage('Terraform Init'){
            steps{
                sh """
                terraform init -reconfigure \
                -backend-config = "key=${params.ENV}/terraform.tfstate"
                """
            }
        }

        stage('Terraform Action'){
            steps{
                script{
                    def tfvarsfile = "envs/${params.ENV}.tfvars"

                    if (params.Action == 'plan'){
                        echo "Running Terraform plan for ${params.ENV} environment"
                        sh " terraform-plan -var-files=${tfvarsfile}"
                    } 

                    else if (params.Action == 'apply'){
                        echo "Running Terraform apply for ${params.ENV} environment"
                        sh "terraform apply -auto-approve -var-files=${tfvarsfile}"
                    }

                    else if (params.Action == 'destroy'){
                        echo "Running Terraform destroy for ${params.ENV} environment"
                        sh "terraform destroy --auto-approve -var-files=${tfvarsfile}"
                    }
                }
            }
        }
    }


}