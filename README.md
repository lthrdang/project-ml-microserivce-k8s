# Python Prediction App in Kubernetes

[![CircleCI](https://circleci.com/gh/lthrdang/project-ml-microserivce-k8s/tree/main.svg?style=svg)](https://circleci.com/gh/lthrdang/project-ml-microserivce-k8s/tree/main)

## Project Overview

This project is a sample for operationalize a Machine Learning Microservice API in local, Docker container, or Kubernetes cluster. It contains a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

It included all neccesary parts and ready for deployment by below instruction:

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:

* Test your project code using linting
* Complete a Dockerfile to containerize this application
* Deploy your containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that your code has been tested

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---

## Prerequisites

* Linux machine (Ubuntu/Debian)
* Python 3.7
* Docker Hub account

## Setup the Environment

* Create a virtualenv with Python 3.7 and activate it. Refer to this link for help on specifying the Python version in the virtualenv.

```bash
python3 -m pip install --user virtualenv
# You should have Python 3.7 available in your host. 
# Check the Python path using `which python3`
# Use a command similar to this one:
python3 -m virtualenv --python=<path-to-Python3.7> .devops
source .devops/bin/activate
```

* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Kubernetes Steps

#### Setup and Configure Docker locally

To setup and configure Docker locally in linux, run this command:

Install docker:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Configure docker:

```bash
# To run docker command without sudo
sudo usermod -aG docker $USER
newgrp docker
```

#### Setup and Configure Kubernetes locally

To setup and configure Kubernetes locally in Linux, run this commands:

```bash
# Install kubectl
sudo snap install kubectl --classic
kubectl version --client

# Install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Setup kubernetes cluster
minikube start
```

#### Create Flask app in Container

Build docker image to run Flask app in

```bash
docker build -t python-prediction-app:latest .
docker tag python-prediction-app:latest <your-dockerhub-id>/python-prediction-app:v1.0.0

docker images
```

Login with docker use your Docker Hub account

```bash
docker login
```

Push Falsk app image to Docker Hub

```bash
docker push <your-dockerhub-id>/python-prediction-app:v1.0.0
```

#### Run via kubectl

Create deployment

```bash
kubectl create deploy python-prediction-app --image=<your-dockerhub-id>/python-prediction-app:v1.0.0
```

Check pod of your deployment is running without errors

```bash
kubectl get pods
```

### File explaination

* `.circleci/config.yaml`: includes configuration for CI pipeline
* `output_txt_files/docker_out.txt`: Outputs text recorded when run `./run_docker.sh`
* `output_txt_files/kubernetes_out.txt`: Outputs text recorded when run `./run_kubernetes.sh`
* `app.py`: includes Python code for prediction application
* `Dockerfile`: includes all commands a user could call on the command line to assemble an image
* `make_predictions.sh`: script to make request to prediction app and get prediction value
* `Makefile`: defines set of tasks to be executed
* `requirements.txt`: includes Python libraries required for prediction app
* `run_docker.sh`: bash script to run python prediction app in docker container
* `run_kubernetes.sh`: bash script to deploy python prediction app in kubernetes cluster
* `upload_docker.sh`:  bash script to upload python prediction app image to Docker Hub
