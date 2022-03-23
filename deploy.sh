docker build -t johnyabu/multi-client-k8s:latest -t johnyabu/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t johnyabu/multi-server-k8s-pgfix:latest -t johnyabu/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t johnyabu/multi-worker-k8s:latest -t johnyabu/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push johnyabu/multi-client-k8s:latest
docker push johnyabu/multi-server-k8s-pgfix:latest
docker push johnyabu/multi-worker-k8s:latest

docker push johnyabu/multi-client-k8s:$SHA
docker push johnyabu/multi-server-k8s-pgfix:$SHA
docker push johnyabu/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johnyabu/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=johnyabu/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=johnyabu/multi-worker-k8s:$SHA