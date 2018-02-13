kubectl apply -f $1/namespace.yml
kubectl apply -f $1/music.yml
kubectl apply -f "$1/ingress-$2.yml"
