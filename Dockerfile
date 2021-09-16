FROM python:3.8-slim
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook && \
    pip install --no-cache notebook jupyterlab && \
    pip install jupyter-client==7.0.2 && \
    pip install jupyter-contrib-core==0.3.3 && \
    pip install jupyter-contrib-nbextensions==0.5.1 && \
    pip install jupyter-core==4.7.1 && \
    pip install jupyter-highlight-selected-word==0.2.0 && \
    pip install jupyter-latex-envs==1.4.6 && \
    pip install jupyter-nbextensions-configurator==0.4.1 && \
    pip install jupyterlab-pygments==0.1.2 

RUN pip install --no-cache notebook jupyterlab
RUN pip install npm
RUN pip install ipywidgets
RUN pip install mstrio-py
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --sys-prefix

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



