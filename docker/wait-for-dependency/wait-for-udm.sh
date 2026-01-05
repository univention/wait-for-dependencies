#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2025 Univention GmbH

set -eo pipefail

if [ "${UDM_API_PASSWORD_FILE}" != "" ]; then
  UDM_API_PASSWORD="$(cat ${UDM_API_PASSWORD_FILE})"
fi

URL="${UDM_API_URL}${UDM_API_PATH:-ldap/base/}"

echo "Checking if the UDM REST API can be reached at: ${URL} ..."
while ! (set +x; echo "-u ${UDM_API_USERNAME}:${UDM_API_PASSWORD}" | curl -K- -o- --fail --header "Accept: application/json" "${URL}"); do
  echo "Checking if the UDM REST API can be reached at: ${URL} ..."
  sleep 2
done

echo "Success, the UDM REST API is available"
