docker build -t brianpolanco/multi-client -f ./client/Dockerfile ./client
docker build -t brianpolanco/multi-server -f ./server/Dockerfile ./server
docker build -t brianpolanco/multi-worker -f ./worker/Dockerfile ./worker
docker push brianpolanco/multi-client
docker push brianpolanco/multi-server
docker push brianpolanco/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brianpolanco/multi-server