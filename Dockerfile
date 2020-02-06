FROM jupyter/datascience-notebook:latest
# https://jupyter-docker-stacks.readthedocs.io/en/latest/

MAINTAINER "Brad Ito" brad@retina.ai

####### root ######
USER root

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get autoremove -y && apt-get clean

####### jovyan user #####
# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

RUN conda update -n base conda

# Install Python external libraries specific to our environment
# Use pip instead of conda because it is less likely to fail/freeze
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# cleanup
RUN rmdir /home/jovyan/work
