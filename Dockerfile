FROM alpine

ARG USER

RUN apk add --no-cache \
    bash \
    curl \
    docker \
    git \
    tar \
    vim \
    openssl

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/v1.21.0/bin/linux/arm64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Install kind
RUN curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.0/kind-linux-arm64 && \
    chmod +x ./kind && \
    mv ./kind /usr/local/bin/kind

# Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

COPY startup.sh /
COPY kind.yml /root/

ENV PATH="${PATH}:/root"

ENTRYPOINT [ "/bin/bash", "/startup.sh" ]