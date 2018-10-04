#!/bin/bash

#Create the secrets for ssl
kubectl apply -f $1/namespace.yml
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=$1.nsx-t.shaozhenpcf.com"

kubectl create secret tls $1-secret --key /tmp/tls.key --cert /tmp/tls.crt -n $1
kubectl apply -f $1/music.yml
kubectl apply -f "$1/ingress-$2.yml"
