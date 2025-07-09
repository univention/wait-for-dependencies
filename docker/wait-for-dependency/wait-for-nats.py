#!/opt/nats-venv/bin/python3
# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2025 Univention GmbH

import os
import asyncio
from nats.aio.client import Client as NATS

async def error_cb(e):
    print(f"Unavailable, waiting 2 seconds. Error: {e}")
    await asyncio.sleep(2)

async def check_nats():
    nc = NATS()
    print("Checking if NATS server can be reached...")
    await nc.connect(
        servers=[f"nats://{os.environ['NATS_HOST']}:{os.environ['NATS_PORT']}"],
        error_cb=error_cb,
        user=os.environ['NATS_USER'],
        password=os.environ['NATS_PASSWORD'],
    )
    print("Success, the NATS server is available")
    await nc.close()

asyncio.run(check_nats())
