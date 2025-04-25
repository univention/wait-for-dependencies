#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2025 Univention GmbH

set -eo pipefail

if [ "${UDM_API_PASSWORD_FILE}" != "" ]; then
  UDM_API_PASSWORD="$(cat ${UDM_API_PASSWORD_FILE})"
fi

echo "Checking if the UDM REST API can be reached at: ${UDM_API_URL}ldap/base/ ..."
while ! (set +x; echo "-u ${UDM_API_USERNAME}:${UDM_API_PASSWORD}" | curl -K- -o- --fail --header "Accept: application/json" "${UDM_API_URL}ldap/base/"); do
  echo "Checking if the UDM REST API can be reached at: ${UDM_API_URL}ldap/base/ ..."
  sleep 2
done

echo "Success, the UDM REST API is available"
