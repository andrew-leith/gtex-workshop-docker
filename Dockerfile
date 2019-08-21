FROM ubuntu:16.04
LABEL maintainer "Andrew Leith <andrew_leith@brown.edu>"
LABEL repository andrew-leith/gtex-workshop-docker
LABEL image gtex-workshop-docker
LABEL tag latest

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -y \
    && apt-get -y install wget \
    && apt-get -y install sudo \
    && apt-get -y install git \
    && apt-get -y install screen \
    && wget https://s3.us-east-2.amazonaws.com/brown-cbc-amis/package_list.txt \
    && apt-get -y install $(grep -vE "^\s*#" package_list.txt  | tr "\n" " ") \
    && apt clean all

RUN useradd -m -d /home/ubuntu -s /bin/bash ubuntu \
    && echo "ubuntu ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu \
    && /bin/bash -c "source /home/ubuntu/.profile"

USER ubuntu
ENV HOME /home/ubuntu

RUN cd /home/ubuntu \
 && mkdir /home/ubuntu/.conda \
 && wget https://repo.continuum.io/miniconda/Miniconda2-4.6.14-Linux-x86_64.sh \
 && bash Miniconda2-4.6.14-Linux-x86_64.sh -b \
 && rm Miniconda2-4.6.14-Linux-x86_64.sh

ENV PATH /home/ubuntu/miniconda2/bin:$PATH

RUN conda install -y numpy scipy jupyter pandas matplotlib

RUN cd /home/ubuntu \
  && wget https://raw.githubusercontent.com/broadinstitute/gtex-ashg2017-workshop/master/GTEx_ASHG17_workshop.ipynb \
  && wget https://github.com/broadinstitute/gtex-ashg2017-workshop/raw/master/data.zip \
  && unzip data.zip \
  && wget https://raw.githubusercontent.com/andrew-leith/gtex-workshop-docker/master/gtex.sh