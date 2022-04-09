// Obtain an Artifactory server instance, defined in Jenkins --> Manage:
def server = Artifactory.server 'net.cernerrepos'

pipeline {
	agent {
		label 'linux_corporate'
	}
	triggers {
		githubPush()
	}
	options {
		skipStagesAfterUnstable()
	}
	environment {
		ARTIFACTORY_REPO = 'helm-snapshot-local'
	}
	stages {
		stage('Checkout from Git') {
			steps {
				checkout([
					$class: 'GitSCM',
					branches: scm.branches,
					doGenerateSubmoduleConfigurations: scm.doGenerateSubmoduleConfigurations,
					extensions: scm.extensions + [[$class: 'CleanBeforeCheckout']],
					userRemoteConfigs: scm.userRemoteConfigs
				])
			}
		}
		stage('Build') {
			steps {
				sh 'find charts -maxdepth 1 -mindepth 1 | xargs helm package'
			}
		}
		stage('Deploy to Artifactory') {
			when {
				allOf {
					not{
						changeRequest ()
					}
				}
				branch 'master'
			}
			steps {
				script {
					// Create the upload specs
					// Only upload the main package, none of its dependencies
					def uploadSpec = """{
						"files": [
							{
								"pattern" : "*.tgz",
								"target" : "${env.ARTIFACTORY_INTEGRATION_REPO}/"
							}
						]
					}"""

					// Upload files to Artifactory:
					buildInfo = server.upload spec: uploadSpec

					// Publish the merged build-info to Artifactory
					server.publishBuildInfo buildInfo
				}
			}
		}
	}
}
