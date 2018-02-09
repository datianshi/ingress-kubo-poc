# ingress-nginx-kubo-poc

## Problems/Challenges

Assume there is no Kubernetes Cloud Provider Load Balancers available

* Have to use node port service to gain ingress traffic
* Have to manually configure an external load balancer for ingress traffic

## Solutions with ingress-niginx

![IDEA](images/PKS-Ingress-Nginx.png)
[service networking


References:

* [Kubernetes ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
* [Kubernetes ingress nginx](https://github.com/kubernetes/ingress-nginx)

## Infrastructure Prerequisites

* A Load Balancer front end port 80
* A wild card DNS record point to the load Balancer

## Deploy Samples

### Install ingress-nginx

```
./install-ingress-nginx.sh
```

```
kubectl get services -n ingress-nginx
NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
default-http-backend   ClusterIP   10.100.200.140   <none>        80/TCP                       3h
ingress-nginx          NodePort    10.100.200.28    <none>        80:30314/TCP,443:32524/TCP   3h
```

Point the Load Balancer to all the worker nodes IP:NodePort (30314 and 32524)

### Deploy Multiple Apps behind same load balancer

```
kubectl create -f music1/namespace.yml
kubectl create -f music1/music.yml
```

```
kubectl get services -n music1
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
music-service   ClusterIP   10.100.200.63   <none>        8080/TCP   2h
```

Provide the ingress rule based on the host header
[ingress.yml](music1/ingress.yml)
```
kubectl create -f music1/ingress.yml
```

Create another app
```
kubectl create -f music2/namespace.yml
kubectl create -f music2/music.yml
kubectl create -f music2/ingress.yml
```

### Access Spring Music

```
* http://music1.test-pks.shaozhenpcf.com
* http://music2.test-pks.shaozhenpcf.com
```
