FROM ubuntu:latest

WORKDIR /home/vscode-tunnel

RUN apt update && apt install ca-certificates wget nano curl git -y && apt clean

RUN curl -o - -L 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' | tar xz && \
    mv code /usr/bin/code


CMD ["/usr/bin/code", "tunnel", "--accept-server-license-terms", "--cli-data-dir", "/etc/vscode-tunnel/data"]

