pipeline {
    agent any
    stages {
        stage('Checkout external proj 🙈🙈🙈') {
            steps {
                git url: 'https://github.com/Abdelfattah1872/Full-Flask-App', branch: 'main' , credentialsId: 'Git'
            }
        }
        stage('Build Docker image Python app and push to ecr 🚚📌') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/app/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 181567667630.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t app:app_"$BUILD_NUMBER" .
                    docker tag app:app_"$BUILD_NUMBER" 181567667630.dkr.ecr.us-east-1.amazonaws.com/app:app_"$BUILD_NUMBER"
                    docker push 181567667630.dkr.ecr.us-east-1.amazonaws.com/app:app_"$BUILD_NUMBER"
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 181567667630.dkr.ecr.us-east-1.amazonaws.com/app:app_"$BUILD_NUMBER"
                    '''
                }
            }
        }
        stage('Build Docker image mysql and push to ecr 🚚📌') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/db/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 181567667630.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t db:db_"$BUILD_NUMBER" .
                    docker tag python_db:db_"$BUILD_NUMBER" 181567667630.dkr.ecr.us-east-1.amazonaws.com/db:db_"$BUILD_NUMBER"
                    docker push 181567667630.dkr.ecr.us-east-1.amazonaws.com/db:db_"$BUILD_NUMBER"
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 181567667630.dkr.ecr.us-east-1.amazonaws.com/db:db_"$BUILD_NUMBER"
                    '''
                }
            }
        }

        stage('Apply Kubernetes files 🚀 🎉 ') {
            steps{
                // withKubeConfig([credentialsId: 'token-eks', serverUrl: 'https://D4D5B42935A6DD8ECD6B3991146B1233.gr7.us-east-1.eks.amazonaws.com']) {
                script {
                    sh '''
                    sed -i \"s|image:.*|image: 181567667630.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"|g\" `pwd`/k8s/flask-app-deployment.yaml
                    sed -i \"s|image:.*|image: 181567667630.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"|g\" `pwd`/k8s/mysql-statefulset.yaml
                    aws eks update-kubeconfig --region us-east-1 --name Giovanni
                    kubectl apply -f $PWD/kubernetes_manifest_file
                    '''
                }
                //}    
            }
        }
        stage('INGRESS and LB URL 🚀 🎉 ') {
            steps{       
                script { 
                    sh '''
                    echo "LB SVC URL 🎉 🎉 🎉"
                    echo $(kubectl get svc flask-service-lb -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'):5002
                    echo "INGRESS URL 🎉 🎉 🎉"
                    echo $(kubectl get ingress ingress-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
                    '''
                }
            }
        }
    }
}