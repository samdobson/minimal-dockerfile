FROM python:3.7-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook && \
    pip install mstrio-py

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
RUN jupyter nbextension install connector-jupyter --py --sys-prefix
RUN jupyter nbextension enable connector-jupyter --py --sys-prefix
WORKDIR ${HOME}
USER ${USER}
