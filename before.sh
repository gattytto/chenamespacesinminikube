#!/bin/bash
kubectl delete pvc/claim-che-workspace -n chewksp
kubectl delete -f chestorage.yaml -f checlusterrolebinding.yaml -f chewksprolebinding.yaml
rm -rf /data/userdata 
kubectl apply -f chestorage.yaml
kubectl apply -f chequota.yaml -n chewksp
