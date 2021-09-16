FROM python:3.8-slim
RUN pip install --no-cache notebook jupyterlab
RUN pip install mstrio-py


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

RUN jupyter contrib nbextension install --user
RUN jupyter nbextension install connector-jupyter --py --sys-prefix
RUN jupyter nbextension enable connector-jupyter --py --sys-prefix
