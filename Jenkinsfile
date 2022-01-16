pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred')
	}

	stages {
        
        stage('Test') {

			steps {
                sh 'docker build -t ayushdock/multi-client:latest -f ./client/Dockerfile.dev ./client'
                sh 'docker run ayushdock/multi-client:latest npm test -- --coverage'
                // coverage ... sp that test script exits eventually
			}
		}

        stage('Build') {

			steps {
				sh 'docker build -t ayushdock/multi-client -f ./client'
                sh 'docker build -t ayushdock/multi-nginx -f ./nginx'
				sh 'docker build -t ayushdock/multi-server -f ./server'
				sh 'docker build -t ayushdock/multi-worker -f ./worker'
            }
		}

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