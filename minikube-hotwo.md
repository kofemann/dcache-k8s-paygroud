# Running dCache in local minikube

(fedora 35)

## install minikube

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

## Fedora 35 with podman

### Add user into sudoers file

```
username ALL=(ALL) NOPASSWD: /usr/bin/podman
```

### enable podman driver

```
minikube config set driver podman
```

## start minikube

```
minikube start
```

### dashboard

```
minikube dashboard
```

or only url

```
minikube dashboard --url
```

> More info
[Minikube Handbook](https://minikube.sigs.k8s.io/docs/handbook/controls/)

## Start dCache

### The required infrastructure

```
kubectl apply -f deployments/zookeeper.yml
kubectl apply -f deployments/kafka.yml
kubectl apply -f deployments/postgresql-service.yml
```

### dCache service

```
kubectl apply -f deployments/dcache-service.yml
```

### status

```
$ kubectl get po -A
NAMESPACE              NAME                                        READY   STATUS    RESTARTS      AGE
default                dcache-door-0                               1/1     Running   0             53s
default                dcache-pool-0                               1/1     Running   0             53s
default                kafka-0                                     1/1     Running   0             78s
default                postgresql-0                                1/1     Running   0             78s
default                zk-0                                        1/1     Running   0             79s

```

## Stop all

```
kubectl delete -f deployments
```
