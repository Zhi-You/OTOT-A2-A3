echo ------- Create Cluster -------
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml

echo ------- Verify Cluster status -------
docker ps
kubectl get nodes 
kubectl cluster-info

echo ------- Setup Deployment and Verify------- 
kubectl apply -f manifests/backend-deployment.yaml
kubectl get deployment/backend 
kubectl get po -lapp=backend –watch

echo ------- Setup Ingress Controller and verify ------- 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl -n ingress-nginx get deploy

echo ------- Setup Service and Verify------- 
kubectl apply -f manifests/backend-service.yaml
kubectl get svc

echo ------- Setup Ingress and Verify------- 
kubectl apply -f manifests/backend-ingress.yaml
kubectl get ingress