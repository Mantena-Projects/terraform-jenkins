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

   stage('move-files') {
      steps {
             script {
                    // Source and destination paths
                    def sourceFile = "inventory.ini"
                    def destinationDir = "/ansible"

                    // Use the 'withCredentials' step to securely handle credentials
                    withCredentials([usernamePassword(credentialsId: 'UserPass', passwordVariable: 'sudoPassword', usernameVariable: 'sudoUser')]) {
                        // Move the file using 'sh' step
                        sh "echo \$sudoPassword | sudo mv ${sourceFile} ${destinationDir}"

                        // You can directly use sudoUser and sudoPassword within this block
                        echo "Username: ${sudoUser}"
                        echo "Password: ${sudoPassword}"

                        // You can perform other operations using sudoUser and sudoPassword within this block
                        // For example, connect to a server, run commands, etc.
                    }
                }
            }
        }
   }
}
