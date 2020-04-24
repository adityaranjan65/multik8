docker build -t adityaranjan65/multi-client:latest -t adityaranjan65/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adityaranjan65/multi-server:latest -t adityaranjan65/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adityaranjan65/multi-worker:latest -t adityaranjan65/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adityaranjan65/multi-client:latest
docker push adityaranjan65/multi-server:latest
docker push adityaranjan65/multi-worker:latest
docker push adityaranjan65/multi-client:$SHA
docker push adityaranjan65/multi-server$SHA
docker push adityaranjan65/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=adityaranjan65/multi-server:$SHA
kubectl set image deployments/client-deployment server=adityaranjan65/multi-client:$SHA
kubectl set image deployments/worker-deployment server=adityaranjan65/worker-server:$SHA