FROM python:3.8-slim
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook
RUN pip install --no-cache notebook jupyterlab
RUN pip install npm
RUN pip install ipywidgets
RUN pip install mstrio-py
RUN jupyter nbextension install connector-jupyter --py --sys-prefix
RUN jupyter nbextension enable connector-jupyter --py --sys-prefix

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}



