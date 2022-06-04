#!/usr/bin/env bash

dockerpath=taikhoan08/python-prediction-app:v1.0.0

echo "Docker ID and Image: $dockerpath"
docker login

docker push $dockerpath
