FROM jenkins/jnlp-slave:3.27-1-alpine

USER root
ENV KUBERNETES_VERSION=v1.17.3

RUN apk --no-cache add jq shadow py2-pip curl ca-certificates  && \
    usermod -G 999 jenkins

#RUN pip --no-cache-dir install docker-compose==${docker_compose_version}
#RUN cd /usr/local/bin && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/b#in/darwin/amd64/kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN curl -O https://storage.googleapis.com/kubernetes-helm/helm-v2.16.3-linux-amd64.tar.gz && \
    tar xvzf helm* && \
    mv linux-amd64/helm /usr/local/bin/ && chmod 755 /usr/local/bin/helm && \
    mv linux-amd64/tiller /usr/local/bin/ && chmod 755 /usr/local/bin/tiller && \
    rm -rf helm* && \
    rm -rf linux-amd64

RUN pip install yq 

#ENV HOME=/config

RUN chmod +x /usr/local/bin/kubectl


USER jenkins
