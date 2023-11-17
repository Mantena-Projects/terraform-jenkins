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
                     withCredentials([usernamePassword(credentialsId: 'UserPass', passwordVariable: 'sudoPassword', usernameVariable: 'sudoUser')]) {
                        // Create an expect script
                        def expectScript = """
                        spawn sudo mv inventory.ini /ansible
                        expect {
                            "assword:" {
                                send "${sudoPassword}\\r"
                                exp_continue
                            }
                            eof
                        }
                        """
                        def expectScriptFile = writeFile file: "${WORKSPACE}/expect_script.exp", text: expectScript
                        // Ensure it's executable
                        sh "chmod +x ${expectScriptFile}"
                        // Run the expect script
                        sh "${expectScriptFile}"
                        // Remove the temporary script
                        sh "rm ${expectScriptFile}"
                    }
                }
            }
        }
   }
}
