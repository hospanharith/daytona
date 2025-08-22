FROM buildpack-deps:jammy-curl

ARG TARGETARCH

# common tools
RUN apt update && export DEBIAN_FRONTEND=noninteractive \
    && apt -y install --no-install-recommends apt-utils vim htop telnet socat expect-dev tini psmisc libgit2-dev \
    python3 python3-pip libx11-dev libxtst-dev libxext-dev libxrandr-dev libxinerama-dev libxi-dev \
    libx11-6 libxrandr2 libxext6 libxrender1 libxfixes3 libxss1 libxtst6 libxi6 \
    xvfb x11vnc novnc xfce4 xfce4-terminal dbus-x11

# build tools
RUN apt update && export DEBIAN_FRONTEND=noninteractive \
    && apt -y install --no-install-recommends openjdk-11-jdk protobuf-compiler libprotobuf-dev

# Install Docker for docker-in-docker feature
RUN apt-get update && \
    apt-get install -y \
        ca-certificates \
        gnupg \
        lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Go for go feature
RUN curl -OL https://go.dev/dl/go1.23.0.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz && \
    rm go1.23.0.linux-amd64.tar.gz
ENV PATH=/usr/local/go/bin:$PATH
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH

# Create Go workspace
RUN mkdir -p $GOPATH/src $GOPATH/bin

# Install swag (Swagger documentation generator for Go)
RUN go install github.com/swaggo/swag/cmd/swag@latest

# Install gow (Go file watcher)
RUN go install github.com/mitranim/gow@latest

# Install Node.js for node feature
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Install Poetry for tools-feature
RUN pip3 install poetry==2.1.3

# Telepresence
RUN curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.17.0/telepresence-linux-${TARGETARCH} -o /usr/local/bin/telepresence && \
    chmod a+x /usr/local/bin/telepresence

CMD ["tail", "-f", "/dev/null"]