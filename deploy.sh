docker build -t yonjuro/multi-client:latest -t yonjuro/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yonjuro/multi-server:latest -t yonjuro/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yonjuro/multi-worker:latest -t yonjuro/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yonjuro/multi-client:latest
docker push yonjuro/multi-server:latest
docker push yonjuro/multi-worker:latest

docker push yonjuro/multi-client:$SHA
docker push yonjuro/multi-server:$SHA
docker push yonjuro/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=yonjuro/multi-client:$SHA
kubectl set image deployments/server-deployment server=yonjuro/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yonjuro/multi-worker:$SHA
