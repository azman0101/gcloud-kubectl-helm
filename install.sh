#!/usr/bin/env bash

set -e
set -x

# add gkh user
adduser -S gkh gkh

# install apk packages
apk update
apk --no-cache add ca-certificates gnupg mysql-client openssl

# install cloud_sql_proxy & kubectl
gcloud components install -q beta cloud_sql_proxy kubectl

# install helm
curl --silent --show-error --fail --location --output get_helm.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get
chmod 700 get_helm.sh
./get_helm.sh --version "${HELM_VERSION}"
rm get_helm.sh

# install kubeval
curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz https://github.com/instrumenta/kubeval/releases/download/"${KUBEVAL_VERSION}"/kubeval-linux-amd64.tar.gz
tar -C /usr/local/bin -xf /tmp/kubeval.tar.gz kubeval
rm /tmp/kubeval.tar.gz

# install sops
curl --silent --show-error --fail --location --output /usr/local/bin/sops https://github.com/mozilla/sops/releases/download/"${SOPS_VERSION}"/sops-"${SOPS_VERSION}".linux
chmod 755 /usr/local/bin/sops

# install yq
curl --silent --show-error --fail --location --output /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/"${YQ_BIN_VERSION}"/yq_linux_amd64
chmod 755 /usr/local/bin/yq

# vals backend installation (optional)
RUN curl -fsSL https://github.com/helmfile/vals/releases/download/v${VALS_VERSION}/vals_${VALS_VERSION}_linux_amd64.tar.gz \
    | tar xzf - -C /usr/local/bin/ vals \
    && chmod +x /usr/local/bin/vals

# set permissions
mkdir -p /data
chown gkh /data /entrypoint.sh /data/commands.sh
chmod +x /entrypoint.sh /data/commands.sh
