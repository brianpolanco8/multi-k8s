docker build -t brianpolanco/multi-client:latest -t brianpolanco/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brianpolanco/multi-server:latest -t brianpolanco/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brianpolanco/multi-worker:latest -t brianpolanco/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push brianpolanco/multi-client:latest
docker push brianpolanco/multi-server:latest
docker push brianpolanco/multi-worker:latest

docker push brianpolanco/multi-client:$SHA
docker push brianpolanco/multi-server:$SHA
docker push brianpolanco/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brianpolanco/multi-server:$SHA
kubectl set image deployments/client-deployment client=brianpolanco/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brianpolanco/multi-worker:$SHA