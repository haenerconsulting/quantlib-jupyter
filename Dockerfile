FROM lballabio/quantlib-python3
MAINTAINER Patrick Haener <contact@haenerconsulting.com>
ARG VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG GIT_COMMIT=unspecified
LABEL Description="A Jupyter notebook server with the QuantLib Python module available"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vcs-url=https://github.com/haenerconsulting/gitserver
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL git_commit=$GIT_COMMIT


RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /requirements.txt

RUN pip3 install jupyter && pip3 install -r /requirements.txt && jupyter-nbextension install rise --py --sys-prefix

ADD templates /notebooks/templates
RUN mkdir /notebooks/user
VOLUME /notebooks/user

EXPOSE 8888

CMD jupyter-notebook --no-browser --allow-root --ip=0.0.0.0 --port=8888 --notebook-dir=/notebooks --NotebookApp.token=""
