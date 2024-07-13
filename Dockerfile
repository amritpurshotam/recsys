# full list of supported tags: https://gitlab.com/nvidia/container-images/cuda/blob/master/doc/supported-tags.md
# FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

# confirmed works
FROM nvcr.io/nvidia/jax:24.04-py3 

RUN apt-get update -y
RUN apt-get -y install python3 \ 
    && apt-get -y install python3-pip

WORKDIR /app/

RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip install --no-cache-dir jupyterlab ipywidgets

COPY requirements.txt /app/

RUN python3 -m pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

ENTRYPOINT [ "jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.allow_origin='*'"]