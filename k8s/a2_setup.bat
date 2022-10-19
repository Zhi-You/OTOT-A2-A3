echo ------- Create Cluster -------
kind create cluster --name kind-1 --config kind/cluster-config.yaml

echo ------- Verify Cluster status -------
docker ps
kubectl get nodes 
kubectl cluster-info
:: timeout 30 
:: note: Due to unreliability in timing, demo will not use script

echo ------- Setup Deployment and Verify------- 
kubectl apply -f manifests/backend-deployment.yaml
kubectl get deployment/backend 
kubectl get po -lapp=backend --watch
:: kubectl rollout status deployment/backend

echo ------- Setup Ingress Controller and verify ------- 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
timeout 10
kubectl -n ingress-nginx get deploy

echo ------- Setup Service and Verify------- 
kubectl apply -f manifests/backend-service.yaml
kubectl get svc

echo ------- Setup Ingress and Verify------- 
kubectl apply -f manifests/backend-ingress.yaml
timeout 10
kubectl get ingress