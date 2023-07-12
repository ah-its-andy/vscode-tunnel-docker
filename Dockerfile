FROM ubuntu:latest

WORKDIR /home/vscode-tunnel

RUN apt update && \
    apt install ca-certificates wget nano curl git gnupg -y && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt update && \
    apt install docker-ce-cli docker-buildx-plugin docker-compose-plugin -y && \
    apt clean && \
    curl -o - -L 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' | tar xz && \
    mv code /usr/bin/code && \
    curl -o - -L 'https://go.dev/dl/go1.20.6.linux-amd64.tar.gz' | tar xz && \
    ln -s /home/vscode-tunnel/go/bin/go /usr/bin/go

CMD ["/usr/bin/code", "tunnel", "--accept-server-license-terms", "--cli-data-dir", "/etc/vscode-tunnel/data"]

