#!/usr/bin/env bash

dockerpath=taikhoan08/python-prediction-app:v1.0.0

kubectl create deploy python-prediction-app --image=$dockerpath 

kubectl get pods

pod_name=$(kubectl get pods | grep python-prediction-app | awk '{print $1}')
kubectl rollout status  deployment python-prediction-app --timeout=180s
kubectl get pods
kubectl port-forward pod/$pod_name --address 0.0.0.0 8000:80