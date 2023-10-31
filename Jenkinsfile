pipeline {
  
  parameters {
       booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
}
  environment {
       AWS_ACCESS_KEY = credentials('AWS_ACCESS_KEY')
       AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
   }

  agent any 
    stages {
    
    stage('plan'){
       steps{
         sh 'dir ("terraform")'
         sh 'pwd;cd terraform/; terraform init'
         sh "pwd;cd terraform/; terraform plan -out tfplan"
         sh 'pwd;cd terraform/; terraform show -no-color tfplan > tfplan.txt'
       }
      }
   
   /*stage('Approval'){
        when{
          not {
            equals expected: true, actual: params.autoApprove
          }
        }
      steps{
         script {
           def plan = readFile 'terraform/tfplan.txt'
           input message: "Do you want to apply the plan?",
           parameters: [text(name: 'Plan', description: 'please review the plan', defaultValue: plan)]
         }
       }
    
      } */ 

   stage('apply'){
     steps{
        sh "pwd; terraform apply -input=false tfplan"
      }
    }
   }
}
