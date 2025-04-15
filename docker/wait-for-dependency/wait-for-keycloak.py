#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2025 Univention GmbH

import requests
import time
import sys
import os

keycloak_url = os.environ.get('KEYCLOAK_URL')
max_retries = 60
retries = 0

while True:
    try:
        response = requests.get(keycloak_url)
        if response.status_code == 200:
            print('Keycloak is available')
            sys.exit(0)
        elif response.status_code == 404:
            print('Realm not ready')
            pass
    except requests.exceptions.ConnectionError:
        print('Could not reach keycloak, retrying...')
        pass
    time.sleep(1)
