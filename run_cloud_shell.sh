#to set env variable for zone and cluster name
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
# create a Kubernetes cluster
gcloud container clusters create $my_cluster --num-nodes 2 --zone $my_zone --enable-ip-alias
#To create a kubeconfig file with the credentials of the current user (to allow authentication) and provide the endpoint details for a specific cluster (to allow communicating with that cluster through the kubectl command-line tool), execute the following command:
gcloud container clusters get-credentials $my_cluster --zone $my_zone
#After the kubeconfig file is populated and the active context is set to a particular cluster, you can use the kubectl command-line tool to execute commands against the cluster
#print out the cluster information for the active context:
kubectl cluster-info
#to get a A line of output indicates the active context cluster, This information is the same as the information in the current-context property of the kubeconfig file.
kubectl config current-context
kubectl create -f exec-liveness.yaml
kubectl create -f readiness-deployment.yaml
kubectl create -f readiness-service.yaml
