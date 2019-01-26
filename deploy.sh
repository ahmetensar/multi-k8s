docker build -t ahmetensar/multi-client:latest -t ahmetensar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ahmetensar/multi-server:latest -t ahmetensar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ahmetensar/multi-worker:latest -t ahmetensar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ahmetensar/multi-client:latest
docker push ahmetensar/multi-server:latest
docker push ahmetensar/multi-worker:latest

docker push ahmetensar/multi-client:$SHA
docker push ahmetensar/multi-server:$SHA
docker push ahmetensar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ahmetensar/multi-client:$SHA
kubectl set image deployments/server-deployment server=ahmetensar/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ahmetensar/multi-worker:$SHA