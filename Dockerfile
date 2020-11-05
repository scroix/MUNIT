# Our base CUDA/OS image.
FROM nvidia/cuda:11.1-cudnn8-runtime-ubuntu18.04

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
ARG anaconda_version=Anaconda3-2020.07-Linux-x86_64.sh

ENV ANACONDA /opt/anaconda
ENV PATH $ANACONDA/bin:$PATH

## Download and setup Anaconda through script.
RUN wget https://repo.continuum.io/archive/$anaconda_version -P /tmp \
    && bash /tmp/$anaconda_version -b -p $ANACONDA \
    && rm /tmp/$anaconda_version -rf

## Create the environment, and activate the environment.
COPY environment.yml .
RUN conda env create -f environment.yml

## Lift the name from the configuration and activate it.
RUN echo "source activate $(head -1 environment.yml | cut -d' ' -f2)" > ~/.bashrc
ENV PATH /opt/conda/envs/$(head -1 environment.yml | cut -d' ' -f2)/bin:$PATH

## Let's get ready.
WORKDIR /app