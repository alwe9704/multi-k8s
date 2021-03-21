docker build -t alwe9704/multi-client -f ./client/Dockerfile ./client
docker build -t alwe9704/multi-server -f ./server/Dockerfile ./server
docker build -t alwe9704/multi-worker -f ./worker/Dockerfile ./worker

docker push alwe9704/multi-client
docker push alwe9704/multi-server
docker push alwe9704/multi-worker

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alwe9704/multi-server
