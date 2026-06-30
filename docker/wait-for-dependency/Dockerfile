# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2023-2024 Univention GmbH

ARG UCS_BASE_IMAGE=gitregistry.knut.univention.de/univention/dev/projects/ucs-base-image/ucs-base
ARG UCS_BASE_IMAGE_TAG=5.3.0-build.20260625@sha256:49a5d9290a1e493d7691039e73d7d275e89014f34b10626c29c79f4bee16f07d

FROM ${UCS_BASE_IMAGE}:${UCS_BASE_IMAGE_TAG} AS build-base

COPY wait-for-keycloak.py /usr/local/bin/
COPY wait-for-udm.sh /usr/local/bin/
COPY wait-for-ldap.sh /usr/local/bin/
COPY wait-for-nats.py /usr/local/bin/

RUN apt-get update \
  && apt-get --assume-yes --verbose-versions --no-install-recommends install \
    ca-certificates=* \
    curl=8.* \
    ldap-utils=2.6.* \
    postgresql-client-17=17.* \
    python3-boto3=1.37.* \
    python3-requests=2.32.* \
    python3-venv=3.13.* \
    python3=3.13.* \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
  && python3 -m venv /opt/nats-venv \
  && /opt/nats-venv/bin/pip install --no-cache-dir nats-py==2.10.0
