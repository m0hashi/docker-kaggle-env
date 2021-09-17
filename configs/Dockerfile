ARG TAG=v103
FROM gcr.io/kaggle-gpu-images/python:${TAG} 

ARG USERNAME=jupyter
ARG GROUPNAME=jupyter
ARG UPASSWD=password
ARG GID=1000
ARG UID=1000
ARG RAPIDSVERSION=21.08
ARG CONDAENV=mlenv

# Add sudo command
RUN rm /etc/apt/sources.list.d/nvidia-ml.list && \
    rm /etc/apt/sources.list.d/cuda.list && \
    rm -rf /tmp/*

RUN apt-get update && \
    apt-get install sudo && \
    apt-get autoremove -y && \
    apt-get clean

# Add user
RUN groupmod ${GROUPNAME} -g ${GID} && \
    # useradd -u ${UID} -g ${GROUPNAME} -m ${USERNAME} --create-home --shell /bin/bash && \
    echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    echo "Set disable_coredump false" >> /etc/sudo.conf && \
    echo ${USERNAME}:${UPASSWD} | chpasswd && \
    # find /opt/conda -type f,d -print0 | xargs -0 -P 512 chown -R ${UID}:${GID}
    find /opt/conda -type f,d -print0 | xargs -0 -P 1024 -L 100 chown -R ${UID}:${GID} 

COPY --chown=${USERNAME}:${USERNAME} clean-layer.sh  /tmp/clean-layer.sh
COPY --chown=${USERNAME}:${USERNAME} ./install-list/apt-install-list.txt /tmp/apt-install-list.txt

# Add BigQuery client proxy settings
ENV PYTHONUSERBASE "/${USERNAME}/.local"
COPY --chown=${USERNAME}:${GROUPNAME}  patches/kaggle_gcp.py /${USERNAME}/.local/lib/python3.7/site-packages/kaggle_gcp.py
COPY --chown=${USERNAME}:${GROUPNAME}  patches/kaggle_secrets.py /${USERNAME}/.local/lib/python3.7/site-packages/kaggle_secrets.py
COPY --chown=${USERNAME}:${GROUPNAME}  patches/kaggle_session.py /${USERNAME}/.local/lib/python3.7/site-packages/kaggle_session.py
COPY --chown=${USERNAME}:${GROUPNAME}  patches/kaggle_web_client.py /${USERNAME}/.local/lib/python3.7/site-packages/kaggle_web_client.py
COPY --chown=${USERNAME}:${GROUPNAME}  patches/kaggle_datasets.py /${USERNAME}/.local/lib/python3.7/site-packages/kaggle_datasets.py
COPY --chown=${USERNAME}:${GROUPNAME}  patches/log.py /${USERNAME}/.local/lib/python3.7/site-packages/log.py
COPY --chown=${USERNAME}:${GROUPNAME}  patches/sitecustomize.py /${USERNAME}/.local/lib/python3.7/site-packages/sitecustomize.py
# Override default imagemagick policies
COPY --chown=${USERNAME}:${GROUPNAME} patches/imagemagick-policy.xml /etc/ImageMagick-6/policy.xml
COPY --chown=${USERNAME}:${GROUPNAME} ./patches/nbconvert-extensions.tpl /opt/kaggle/nbconvert-extensions.tpl
COPY --chown=${USERNAME}:${GROUPNAME} ./patches/template_conf.json /opt/kaggle/conf.json


USER ${USERNAME}
RUN echo ${USERNAME}
WORKDIR /home/${USERNAME}
ENV PATH /opt/conda/bin:$PATH
RUN echo "PATH=/opt/conda/bin/:$PATH" >> /home/${USERNAME}/.bashrc && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/${USERNAME}/.bashrc && \
    echo "conda activate ${CONDAENV}" >> /home/${USERNAME}/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

RUN mkdir -p ~/.local && \
    mkdir -p ~/workspace && \
    mkdir -p ~/.ssh && \
    mkdir -p ~/.kaggle && \
    mkdir -p ~/.aws

COPY --chown=${USERNAME}:${GROUPNAME} docker-entrypoint.sh /home/${USERNAME}/.local/bin/docker-entrypoint.sh
COPY --chown=${USERNAME}:${GROUPNAME} run-jupyter.sh /home/${USERNAME}/.local/bin/run-jupyter.sh
COPY --chown=${USERNAME}:${GROUPNAME} run-mlflow.sh /home/${USERNAME}/.local/bin/run-mlflow.sh
RUN echo "PATH=~/.local/bin/:$PATH" >> /home/${USERNAME}/.bashrc

RUN pip install mlflow && \
    /tmp/clean-layer.sh
RUN pip install jupyterlab==3.0 jupyterlab-lsp==3.8.0 jedi-language-server && \
    /tmp/clean-layer.sh
RUN pip install jupyterlab_vim && \
    /tmp/clean-layer.sh

USER root
RUN mkdir /var/run/sshd
