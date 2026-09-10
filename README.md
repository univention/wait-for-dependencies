# container-wait-for-dependencies

This repository builds the `wait-for-dependency` container image.
It is a utility container and holds no application code.
It provides small scripts that block until a Nubus dependency answers,
so that a Deployment or Job can run them as an initContainer
and start its own containers only once the dependency is up.

It improves the Nubus installation experience,
especially the initial deployment.
Without it, the dependency chain of Nubus components
would run into significant `CrashLoopBackOff` delays.
A pod several steps down the chain would sit there
for minutes after its dependency became ready.

The initContainer-based implementation provides clear signals
to the administrator about the state of the Nubus deployment.
`kubectl get pods` shows the pod as `Init:0/1`,
and the initContainer's name and log say which dependency it is waiting for.

## Scripts

Every script is on the `PATH` in `/usr/local/bin`
and takes its configuration from the environment.

| Script | Waits for | Environment variables |
| --- | --- | --- |
| `wait-for-ldap.sh` | An LDAP server answering a base-object search | `LDAP_URI`, `LDAP_ADMIN_USER`, `LDAP_ADMIN_PASSWORD_FILE` |
| `wait-for-udm.sh` | The UDM REST API returning a 2xx for one object | `UDM_API_URL`, `UDM_API_USERNAME`, `UDM_API_PASSWORD` or `UDM_API_PASSWORD_FILE`, `UDM_API_PATH` (default `ldap/base/`) |
| `wait-for-keycloak.py` | Keycloak returning a 200 for a URL, typically a realm | `KEYCLOAK_URL` |
| `wait-for-nats.py` | A NATS server accepting an authenticated connection | `NATS_HOST`, `NATS_PORT`, `NATS_USER`, `NATS_PASSWORD` |

## Usage

```yaml
initContainers:
  - name: wait-for-udm
    image: "gitregistry.knut.univention.de/univention/dev/nubus-for-k8s/wait-for-dependencies/wait-for-dependency:latest"
    command: ["wait-for-udm.sh"]
    env:
      - name: UDM_API_URL
        value: "http://nubus-udm-rest-api:9979/univention/udm/"
      - name: UDM_API_USERNAME
        value: "cn=admin"
      - name: UDM_API_PASSWORD
        valueFrom:
          secretKeyRef:
            name: nubus-ldap-server-admin
            key: password
```

## Retry behaviour

The scripts have no timeouts.
Each one retries every one or two seconds until the dependency answers.
Instead, configure the timeout at the Kubernetes level,
through the pod's `activeDeadlineSeconds` or the Job's `backoffLimit`.

## Included tooling

The image also includes `curl`, `ldapsearch`, `psql`,
and the Python packages `requests`, `boto3` and `nats-py`.
Besides the scripts above,
you can run your own script in this container
by mounting it from a ConfigMap.
Several Nubus component charts do this.

## Adding a script

Put the script next to the others in `docker/wait-for-dependency/`
and copy it into `/usr/local/bin` in the `Dockerfile`.
