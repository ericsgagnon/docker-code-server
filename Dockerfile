
ARG VERSION=dev

FROM ericsgagnon/ide-base:${VERSION} as base

# this may not be necessary but may give insight on source files
ENV WORKSPACE="/tmp/workspace/code-server"
COPY . ${WORKSPACE}/

RUN curl -fsSL https://code-server.dev/install.sh | bash -s -- --method=standalone --prefix=/usr/local

COPY code-server-run /etc/services.d/code-server/run

EXPOSE 8080


ENV SERVICE_URL=https://open-vsx.org/vscode/gallery
ENV ITEM_URL=https://open-vsx.org/vscode/item

ENV SERVICE_URL=https://marketplace.visualstudio.com/_apis/public/gallery
ENV ITEM_URL=https://marketplace.visualstudio.com/items

