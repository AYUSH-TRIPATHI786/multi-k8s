docker build -t ayushdock/multi-client:latest -t ayushdock/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ayushdock/multi-server:latest -t ayushdock/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ayushdock/multi-worker:latest -t ayushdock/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ayushdock/multi-client:latest
docker push ayushdock/multi-server:latest
docker push ayushdock/multi-worker:latest
docker push ayushdock/multi-client:$SHA
docker push ayushdock/multi-server:$SHA
docker push ayushdock/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ayushdock/multi-server:$SHA
kubectl set image deployments/client-deployment client=ayushdock/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ayushdock/multi-worker:$SHA
