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
                        // Create a temporary script with the sudo command
                        def scriptContent = "#!/bin/bash\nsudo mv inventory.ini /ansible"
                        def scriptFile = sh(script: "mktemp temp_script.XXXXXXXXXX", returnStdout: true).trim()
                        writeFile file: scriptFile, text: scriptContent
                        // Ensure it's executable
                        sh "chmod +x ${scriptFile}"
                        // Set SUDO_ASKPASS environment variable to an empty script
                        writeFile file: 'empty_script.sh', text: '#!/bin/bash\nexit 0'
                        sh "export SUDO_ASKPASS=\"${WORKSPACE}/empty_script.sh\""
                        // Run the script with sudo -A
                        sh "sudo -A -S ${scriptFile}"
                        // Remove the temporary script
                        sh "rm ${scriptFile}"
                    }
                }
            }
        }
   }
}
