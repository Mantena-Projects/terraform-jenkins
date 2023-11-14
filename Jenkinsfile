pipeline {
  
  parameters {
       booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
}
  environment {
       AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
       AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
   }

  environment {
        ANSIBLE_DIRECTORY = "/ansible"
    }

  agent any 
    stages {
    
    stage('plan'){
       steps{
         sh 'pwd; terraform init'
         sh "pwd; terraform plan -out tfplan"
         sh 'pwd; terraform show -no-color tfplan > tfplan.txt'
       }
      }
   
    stage('Approval'){
        when{
          not {
            equals expected: true, actual: params.autoApprove
          }
        }
      steps{
         script {
           def plan = readFile 'tfplan.txt'
           input message: "Do you want to apply the plan?",
           parameters: [text(name: 'Plan', description: 'please review the plan', defaultValue: plan)]
         }
       }
    
      } 

   stage('apply'){
     steps{
        sh "pwd; terraform apply -input=false tfplan"
        sh "terraform output > output.txt"
      }
    }
   stage('python-script'){
     steps{
        sh "python3 boto3.py"
      }
    }

   stage('files-upload'){
     steps{
       script {
                   withCredentials([
                        file(credentialsId: 'inventory.ini', variable: 'INVENTORY_FILE'),
                        file(credentialsId: 'private_key.pem', variable: 'KEY_FILE')
                    ]) {
                        sh "mv \${INVENTORY_FILE} \${ANSIBLE_DIRECTORY}"
                        sh "mv \${KEY_FILE} \${ANSIBLE_DIRECTORY}"
                    }
                }
      }
    }
   }
}
