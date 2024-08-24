pipeline {
    agent any
    tools {
        jdk 'jdk17'      // Ensure JDK 17 is installed and configured in Jenkins
        nodejs 'node16'  // Ensure Node.js 22 is installed and configured in Jenkins
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'  // Ensure SonarQube scanner is installed
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()  // Clean up the workspace before starting the build
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Ahmedmadara/Netflix-Clone-CI-CD-Pipeline.git'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-scanner') {  // Ensure SonarQube environment is configured
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=Netflix \
                    -Dsonar.projectKey=Netflix \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://192.168.30.20:9000'''
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'  // Ensure SonarQube token is configured
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'  // Install Node.js dependencies
            }
        }
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'  // Ensure Dependency-Check is configured
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh "trivy fs . > trivyfs.txt"  // Scan file system with Trivy
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', url: '') {  // Ensure Docker credentials are configured
                        sh "docker build --build-arg TMDB_V3_API_KEY=Aj7ay86fe14eca3e76869b92 -t netflix ."
                        sh "docker tag netflix ahmedmadara/netflix:latest"
                        sh "docker push ahmedmadara/netflix:latest"
                    }
                }
            }
        }
        stage('TRIVY Image Scan') {
            steps {
                sh "trivy image ahmedmadara/netflix:latest > trivyimage.txt"  // Scan Docker image with Trivy
            }
        }
        stage('Deploy to Container') {
            steps {
                sh 'docker run -d --name netflix -p 8081:80 ahmedmadara/netflix:latest'  // Run Docker container
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    dir('Kubernetes') {
                        withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {  // Ensure Kubernetes credentials and config are correct
                            sh 'kubectl apply -f deployment.yml'
                            sh 'kubectl apply -f service.yml'
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            emailext(
                attachLog: true,
                subject: "${currentBuild.result}: Build #${env.BUILD_NUMBER}",
                body: """\
                    Project: ${env.JOB_NAME}<br/>
                    Build Number: ${env.BUILD_NUMBER}<br/>
                    URL: ${env.BUILD_URL}<br/>
                """,
                to: 'ahmed554aad@gmail.com',
                attachmentsPattern: 'trivyfs.txt,trivyimage.txt'
            )
        }
    }
}
