//@Library(['jenkins2-shared-library'])_ 
def server = Artifactory.server 'Artifactory'
def buildInfo
def version = "1.0.0.${BUILD_NUMBER}"
def rtMaven = Artifactory.newMavenBuild()
pipeline {
  
  agent any
  
  environment {
  LIQUIBASE_COMMAND_CHANGELOG_FILE="changelog.sql"
  }
  stages {
    	stage('upload-artifact'){
   	 steps{
    	  script {
   		 def uploadSpec = """{
      		  "files": [
         		{
				"target": "ind-test/upload/$LIQUIBASE_COMMAND_CHANGELOG_FILE",
				"pattern": "$LIQUIBASE_COMMAND_CHANGELOG_FILE"
         		}
        		]
     			}"""
    		server.upload spec: uploadSpec 
    			}
  		 }
  	}
 
 	stage('Deploy to Dev') {
			steps {
				script {
						downloadSpec = """{
						  "files": [{
								"target": "ind-test/download/$LIQUIBASE_COMMAND_CHANGELOG_FILE",
								"pattern": "ind-test/upload/*.sql"
						  }]
						}"""
						server.download(downloadSpec)
						//env.database="Embark_Extract_Dev"
						env.propfile="liquibase.properties"
						creds = "db-creds"
						withCredentials([usernamePassword(credentialsId: "$creds", passwordVariable: 'password', usernameVariable: 'username')]) {
							rtMaven.tool = 'Maven-3.8.6'
							rtMaven.resolver releaseRepo: 'ind-test', snapshotRepo: 'default-libs-snapshot', server: server
							buildInfo = Artifactory.newBuildInfo()
							rtBuildInfo(captureEnv: true, )
							sh "cp ind-test/download/upload/$LIQUIBASE_COMMAND_CHANGELOG_FILE $LIQUIBASE_COMMAND_CHANGELOG_FILE"
							rtMaven.run pom: 'pom.xml', goals: "mvn liquibase:tag -Djavax.net.ssl.trustStore=/opt/jenkins/home/truststore -Djavax.net.ssl.trustStorePassword=changeit -Dliquibase.username=$username -Dliquibase.password=$password -Dliquibase.tag=${version}".toString(), buildInfo: buildInfo
							rtMaven.run pom: 'pom.xml', goals: "mvn liquibase:update -Djavax.net.ssl.trustStore=/opt/jenkins/home/truststore -Djavax.net.ssl.trustStorePassword=changeit -Dliquibase.username=$username -Dliquibase.password=$password".toString(), buildInfo: buildInfo
						}
				}
			}
		}
	}
}



