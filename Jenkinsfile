pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred')
	}

	stages {
        
        stage('Test') {
            agent {
                // Equivalent to "docker build -t ayushdock/multi-client:latest -f Dockerfile.dev ./client
                dockerfile {
                    filename 'Dockerfile.dev'
                    dir 'client'
                    additionalBuildArgs  '-t ayushdock/multi-client:latest'
                }
            }
			steps {
                // sh 'docker build -t ayushdock/multi-client:latest -f Dockerfile.dev ./client'
                sh 'npm run test -- --coverage'
                // coverage ... sp that test script exits eventually
			}
		}

        stage('Prod-Build-client') {
            agent {
                dockerfile {
                    dir 'client'
                    additionalBuildArgs  '-t ayushdock/multi-client'
                }
            }
			
		}

        stage('Prod-Build-nginx') {
            agent {
                dockerfile {
                    dir 'nginx'
                    additionalBuildArgs  '-t ayushdock/multi-nginx'
                }
            }
			
		}

        stage('Prod-Build-server') {
            agent {
                dockerfile {
                    dir 'server'
                    additionalBuildArgs  '-t ayushdock/multi-server'
                }
            }
			
		}

        stage('Prod-Build-worker') {
            agent {
                dockerfile {
                    dir 'client'
                    additionalBuildArgs  '-t ayushdock/multi-worker'
                }
            }
			
		}

        // steps {
        //     sh 'docker build -t ayushdock/multi-client ./client'
        //     sh 'docker build -t ayushdock/multi-nginx ./nginx'
        //     sh 'docker build -t ayushdock/multi-server ./server'
        //     sh 'docker build -t ayushdock/multi-worker ./worker'
        // }

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push ayushdock/multi-client'
				sh 'docker push ayushdock/multi-nginx'
				sh 'docker push ayushdock/multi-server'
				sh 'docker push ayushdock/multi-worker'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}

