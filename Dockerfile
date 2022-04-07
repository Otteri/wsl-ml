###################################################################
# Author: Joni Airaksinen (Otteri)
# Build: $ docker build --t dependency-stage -t wsl-ml:latest .
# Run:   $ docker run --gpus all -it wsl-ml:latest
#
# Keywords: CUDA 11.3, cudnn 8, TensorRT 8, ubuntu20.04
###################################################################

FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04 AS dependency-stage

# Setup user account
RUN useradd -ms /bin/bash ml

# Ubuntu 20.04 requres this, because otherwise we get tzdata dialogue
ENV DEBIAN_FRONTEND noninteractive

# Install common build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    curl \
    dialog apt-utils \
    git \
    g++ \
    libboost-all-dev \
    libssl-dev \
    libtool \
    libyaml-cpp-dev \
    lsb-release \
    make \
    pkg-config \
    python3-pip \
    python3-setuptools \
    software-properties-common \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install python packages
COPY requirements.txt /app/requirements.txt
RUN python3 -m pip install --upgrade pip && pip install -r /app/requirements.txt
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install specific TensorRT version
RUN version="8.0.3-1+cuda11.3" \
    && apt-get update && apt-get install -y \
    libnvinfer8=${version} \
    libnvonnxparsers8=${version} \
    libnvparsers8=${version} \
    libnvinfer-plugin8=${version} \
    libnvinfer-dev=${version} \
    libnvonnxparsers-dev=${version} \
    libnvparsers-dev=${version} \
    libnvinfer-plugin-dev=${version} \
    python3-libnvinfer=${version}

# Install OpenCV
RUN apt-get install -y libopencv-dev python3-opencv

USER ml
WORKDIR /app
