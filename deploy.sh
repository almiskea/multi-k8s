docker build -t almiskea/multi-client:latest -t almiskea/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t almiskea/multi-server:latest -t almiseka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t almiskea/multi-worker:latest -t almiskea/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push almiskea/multi-client:latest
docker push almiskea/multi-server:latest
docker push almiskea/multi-worker:latest

docker push almiskea/multi-client:$SHA
docker push almiskea/multi-server:$SHA
docker push almiskea/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deploymentcd server=almiskea/multi-server:$SHA
kubectl set image deployment/client-deploymentcd client=almiskea/multi-client:$SHA
kubectl set image deployment/worker-deploymentcd worker=almiskea/multi-worker:$SHA