#!/bin/bash
kubectl apply -f checlusterrolebinding.yaml
kubectl apply -f chewksprolebinding.yaml --namespace=chewksp
