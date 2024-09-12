# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2023-2024 Univention GmbH

ARG UCS_BASE_IMAGE=gitregistry.knut.univention.de/univention/components/ucs-base-image/ucs-base-520
ARG UCS_BASE_IMAGE_TAG=0.13.1-post-main-build-2024-09-09

FROM ${UCS_BASE_IMAGE}:${UCS_BASE_IMAGE_TAG} AS build-base


RUN apt-get update \
    && apt-get --assume-yes --verbose-versions --no-install-recommends install \
      ca-certificates=* \
      curl=7.88.* \
      ldap-utils=2.5.* \
      python3-boto3=1.26.* \
      postgresql-client-15=15.* \
      python3=3.11.* \
      python3-requests=2.28.* \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
