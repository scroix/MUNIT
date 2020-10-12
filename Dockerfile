# Our base CUDA/OS image.
FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

# Our Ubuntu environment and packages.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        wget \
        libopencv-dev \
        python-opencv \
        build-essential \
        cmake \
        git \
        curl \
        ca-certificates \
        libjpeg-dev \
        libpng-dev \
        axel \
        zip \
        unzip

# Our Anaconda environment and packages.
ARG anaconda_version=Anaconda3-2019.07-Linux-x86_64.sh

ENV ANACONDA /opt/anaconda
ENV PATH $ANACONDA/bin:$PATH

## Download and setup Anaconda through script.
RUN wget https://repo.continuum.io/archive/$anaconda_version -P /tmp \
    && bash /tmp/$anaconda_version -b -p $ANACONDA \
    && rm /tmp/$anaconda_version -rf

## Install packages for this project, and avoid issues from updating.
RUN conda config --set auto_update_conda False

RUN conda install -y -c anaconda pip cudatoolkit=10.2
RUN conda install -y -c pytorch pytorch=1.6 torchvision 
RUN conda install -y -c conda-forge torchfile tensorboard tensorboardx pyyaml=3.13

## Let's get ready.
WORKDIR /app