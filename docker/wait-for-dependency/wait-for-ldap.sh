#!/bin/bash
# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2025 Univention GmbH

set -euxo pipefail

while ! ldapsearch -H "$LDAP_URI" -D "$LDAP_ADMIN_USER" -y "$LDAP_ADMIN_PASSWORD_FILE" -b "" -s base -LLL; do
  echo "Checking if LDAP Server can be reached..."
  sleep 2
done

echo "Success, the LDAP Server is available"
