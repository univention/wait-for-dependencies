# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2023-2024 Univention GmbH

ARG UCS_BASE_IMAGE=gitregistry.knut.univention.de/univention/dev/projects/ucs-base-image/ucs-base
ARG UCS_BASE_IMAGE_TAG=5.2.5-build.20260514@sha256:81b104694a78cf36043f84b5d9e4b3b0cbbe6777e46877239a44f08249379119

FROM ${UCS_BASE_IMAGE}:${UCS_BASE_IMAGE_TAG} AS build-base

COPY wait-for-keycloak.py /usr/local/bin/
COPY wait-for-udm.sh /usr/local/bin/
COPY wait-for-ldap.sh /usr/local/bin/
COPY wait-for-nats.py /usr/local/bin/

RUN apt-get update \
  && apt-get --assume-yes --verbose-versions --no-install-recommends install \
    ca-certificates=* \
    curl=7.88.* \
    ldap-utils=2.5.* \
    postgresql-client-15=15.* \
    python3-boto3=1.26.* \
    python3-requests=2.28.* \
    python3-venv=3.11.* \
    python3=3.11.* \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* \
  && python3 -m venv /opt/nats-venv \
  && /opt/nats-venv/bin/pip install --no-cache-dir nats-py==2.10.0
