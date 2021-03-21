docker build -t alwe9704/multi-client:latest -t alwe9704/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alwe9704/multi-server:latest -t alwe9704/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alwe9704/multi-worker:latest -t alwe9704/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alwe9704/multi-client:$SHA
docker push alwe9704/multi-worker:$SHA
docker push alwe9704/multi-server:$SHA

docker push alwe9704/multi-client:latest
docker push alwe9704/multi-server:latest
docker push alwe9704/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alwe9704/multi-server:$SHA
kubectl set image deployments/client-deployment client=alwe9704/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alwe9704/multi-worker:$SHA
