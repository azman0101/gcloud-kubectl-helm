
FROM google/cloud-sdk:457.0.0-alpine

LABEL org.opencontainers.image.source="https://github.com/azman0101/gcloud-kubectl-helm"

# renovate: datasource=github-release depName=helm/helm extractVersion="^v(?<version>.*)$"
ENV HELM_VERSION v3.8.2
ENV HELM2_VERSION v2.17.0
# renovate: datasource=github-release depName=instrumenta/kubeval extractVersion="^v(?<version>.*)$"
ENV KUBEVAL_VERSION v0.16.1
# renovate: datasource=github-release depName=getsops/sops extractVersion="^v(?<version>.*)$"
ENV SOPS_VERSION v3.7.3
# renovate: datasource=github-release depName=mikefarah/yq extractVersion="^v(?<version>.*)$"
ENV YQ_BIN_VERSION v4.30.8
# renovate: datasource=github-release depName=helmfile/vals extractVersion="^v(?<version>.*)$"
ENV VALS_VERSION v0.21.0
# renovate: datasource=github-release depName=jkroepke/helm-secrets extractVersion="^v(?<version>.*)$"
ENV HELM_SECRETS_VERSION v4.2.2
# renovate: datasource=github-release depName=hayorov/helm-gcs extractVersion="^(?<version>.*)$"
ENV HELM_GCS_VERSION 0.4.1

# renovate: datasource=github-release depName=databus23/helm-diff extractVersion="^v(?<version>.*)$"
ENV HELM_DIFF_VERSION v3.8.1
# renovate: datasource=github-release depName=helm/helm-mapkubeapis extractVersion="^v(?<version>.*)$"
ENV HELM_MAPKUBEAPIS_VERSION v0.4.0

COPY entrypoint.sh entrypoint.sh
COPY commands.sh /data/commands.sh
COPY install.sh /tmp/install.sh
COPY helm-init.sh /tmp/helm-init.sh

RUN chmod +x /tmp/install.sh /tmp/helm-init.sh && \
    /tmp/install.sh

VOLUME /data

USER gkh

RUN /tmp/helm-init.sh

ENTRYPOINT ["/entrypoint.sh"]
