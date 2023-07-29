ARG WORKSPACE_GO_VERSION
FROM gitpod/workspace-go:${WORKSPACE_GO_VERSION:-2023-07-20-19-56-24}

ARG ARCH
ENV ARCH=${ARCH:-amd64}
ARG OS
ENV OS=${OS:-linux}
ARG OPERATOR_SDK_VERSION
ENV OPERATOR_SDK_VERSION=${OPERATOR_SDK_VERSION:-v1.31.0}
ENV OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${OPERATOR_SDK_VERSION}

RUN cd /tmp && curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH} &&\
    curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt &&\
    curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt.asc &&\
    gpg --keyserver keyserver.ubuntu.com --recv-keys 052996E2A20B5C7E &&\
    gpg -u "Operator SDK (release) <cncf-operator-sdk@cncf.io>" --verify checksums.txt.asc &&\
    grep operator-sdk_${OS}_${ARCH} checksums.txt | sha256sum -c - &&\
    chmod +x operator-sdk_${OS}_${ARCH} &&\ 
    sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk
