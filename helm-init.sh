#!/usr/bin/env bash

set -e
set -x

if helm version --client | grep -q 'SemVer:"v2';then
    helm init --client-only
    helm plugin install https://github.com/hayorov/helm-gcs.git --version "${HELM_GCS_VERSION}"
    helm plugin install https://github.com/databus23/helm-diff --version "${HELM_DIFF_VERSION}"
    helm plugin list
else
    helm repo add stable https://charts.helm.sh/stable
    helm plugin install https://github.com/jkroepke/helm-secrets --version "${HELM_SECRETS_VERSION}"
    helm plugin install https://github.com/hayorov/helm-gcs.git --version "${HELM_GCS_VERSION}"
    helm plugin install https://github.com/databus23/helm-diff --version "${HELM_DIFF_VERSION}"
    helm plugin install https://github.com/helm/helm-mapkubeapis --version "${HELM_MAPKUBEAPIS_VERSION}"
    helm plugin list
fi
