#!/usr/bin/env bash

docker build -t python-prediction-app:latest .
docker tag python-prediction-app:latest taikhoan08/python-prediction-app:v1.0.0

docker images

docker run -p 8000:80 python-prediction-app:latest