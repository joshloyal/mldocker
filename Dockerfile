# Python Data Science Environment
#
# VERSION       1.0

FROM ubuntu:trusty
MAINTAINER Joshua Loyal <jloyal25@gmail.com>

# update repos and install basic dependencies 
# NOTE: build-essential includes:
#   -dpkg-dev, g++, gcc, hurd-dev, libc, make
RUN apt-get update && apt-get install -y \
    python-pip \
    python-dev \
    build-essential

# install linear-algebra dependencies
RUN apt-get install -y libatlas-base-dev \
    gfortran \
    liblapack-dev

# install some basic command line tools
RUN apt-get install -y git curl binutils

# install dependencies 
RUN apt-get install -y libpng3 libjpeg8 libfreetype6-dev \
    libxft-dev \
    libffi-dev \
    libx11-dev \
    libxpm-dev \
    libxext-dev \
    libssl-dev \
    libpcre3-dev \
    libgl1-mesa-dev \
    libglew1.5-dev \
    libftgl-dev \
    libmysqlclient-dev \
    libfftw3-dev \
    libcfitsio3-dev \
    graphviz-dev \
    libavahi-compat-libdnssd-dev \
    libldap2-dev \
    libxml2-dev \
    libkrb5-dev \
    libgsl0-dev \
    libqt4-dev 

# install numpy
RUN pip install \
    numpy==1.9.1

# install python & scientific libraries
ENV TEMP /tmp
RUN curl https://raw.githubusercontent.com/ShallowLearning/slearn/master/requirements.txt > $TEMP/requirements.txt
RUN pip install -r $TEMP/requirements.txt

# xgboost
RUN git clone https://github.com/dmlc/xgboost.git $TEMP/xgboost && \
    cd $TEMP/xgboost && \
    ./build.sh && \
    cd python-package && \
    python setup.py install && \
    cd .. && \
    cp tests/python/test_basic.py . && \
    python -c "import test_basic ; test_basic.test_basic()" && \
    cd / && \
    rm -rf $TEMP/xgboost

# root.cern.ch
#
#RUN sudo apt-get install -y root-system \
#    libroot-bindings-python-dev \
#    libroot-roofit5.34 \
#ENV LD_LIBRARY_PATH /usr/lib/x86_6-linux-gnu/root5.34/:$LD_LIBRARY_PATH
#ENV PYTHONPATH=/usr/lib/x86_64-linux-gnu/root5.34:$PYTHONPATH

# rootpy
# RUN easy_install -U pip
# RUN pip install \
#    rootpy==0.7.1 \
#    root_numpy==4.1.2 

# create datum user, i.e. don't do everything as root
RUN useradd -d/home/datum -m datum
USER datum

# TEST
CMD ["bash"]
