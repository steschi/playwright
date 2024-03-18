ARG DEBIAN_FRONTEND=noninteractive
ARG PLAYWRIGHT_TAG=v1.42.1-jammy
ARG GITHUB_CLI_VERSION=2.45.0

FROM mcr.microsoft.com/playwright:${PLAYWRIGHT_TAG}

# Re-assigning ARGs to make them available in the image
ARG PLAYWRIGHT_TAG
ARG DEBIAN_FRONTEND
ARG GITHUB_CLI_VERSION

RUN apt-get update && apt-get install -y \
    git-lfs \
    && rm -rf /var/lib/apt/lists/*

RUN git lfs install

RUN set -ex; \
    curl -OL "https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_amd64.deb"; \
    dpkg -i "gh_${GITHUB_CLI_VERSION}_linux_amd64.deb"; \
    rm -rf "gh_${GITHUB_CLI_VERSION}_linux_amd64.deb"; \
    gh --version;