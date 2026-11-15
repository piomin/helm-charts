# Helm Chart for Spring Boot REST App

## Parameters

### General

| Name           | Description                                 | Value |
|----------------|---------------------------------------------|-------|
| `replicaCount` | Number of replicas                          | 1     |
| `envs`         | List of environment variables (name, value) | []    |
| `ports`        | List of exposed ports (name, value)         | `[{name: http, value: 8080}]` |

### Image parameters

| Name                | Description                                                  | Value                |
|---------------------|--------------------------------------------------------------|----------------------|
| `image.repository`  | Image repository                                             | `piomin/sample-spring-kotlin-microservice` |
| `image.tag`         | Image tag (immutable tags are recommended)                   | `1.1`                |

### Application parameters

| Name                | Description                                                  | Value                |
|---------------------|--------------------------------------------------------------|----------------------|
| `app.name`          | The name of deployment                                       | `sample-spring-boot-api` |
| `app.environment`   | The value of `env` label                                     | `dev`                |
| `app.owner`         | The value of `owner` label                                   | `default`            |

### Global

| Name               | Description       | Value |
|--------------------|-------------------|-------|
| `nameOverride`     | The name of chart | ``    |
| `fullnameOverride` | The name of app   | ``    |

### Resources

| Name                        | Description        | Value    |
|-----------------------------|--------------------|----------|
| `resources.limits.cpu`      | Limit for CPU      | `1000m` |
| `resources.limits.memory`   | Limit for memory   | `512Mi`  |
| `resources.requests.cpu`    | Request for CPU    | `100m`   |
| `resources.requests.memory` | Request for memory | `256Mi`  | 

### Liveness probe

| Name                           | Description                                       | Value                       |
|--------------------------------|---------------------------------------------------|-----------------------------|
| `liveness.initialDelaySeconds` | Seconds to wait after container start            | 10                          |
| `liveness.port`                | Name or number of the probed port                          | `http`                      |
| `liveness.path`                | HTTP path of the probe                        | `/actuator/health/liveness` |
| `liveness.timeoutSeconds`      | Number of seconds after which the probe times out | 3                           | 
| `liveness.failureThreshold`    | Number of max failures in row                     | 3                           | 
| `liveness.successThreshold`    | Minimum consecutive successes to be successful    | 1                           | 
| `liveness.periodSeconds`       | How often (in seconds) to perform the probe       | 5                           |

### Readiness probe

| Name                             | Description                                       | Value                        |
|----------------------------------|---------------------------------------------------|------------------------------|
| `readiness.initialDelaySeconds`  | Seconds to wait after container start            | 10                           |
| `readiness.port`                 | Name or number of the probed port                          | `http`                       |
| `readiness.path`                 | HTTP path of the probe                        | `/actuator/health/readiness` |
| `readiness.timeoutSeconds`       | Number of seconds after which the probe times out | 3                            | 
| `readiness.failureThreshold`     | Number of max failures in row                     | 3                            | 
| `readiness.successThreshold`     | Minimum consecutive successes to be successful    | 1                            | 
| `readiness.periodSeconds`        | How often (in seconds) to perform the probe       | 5                            |

### Envs

| Name                    | Description                                         | Value |
|-------------------------|-----------------------------------------------------|-------|
| `envs`                  | List of included environment variables to container | []    |
| `extraEnvVarsSecret`    | List of included secret env refs to container       | []    |
| `extraEnvVarsConfigMap` | List of included configmap env refs to container    | []    |

Each item of `extraEnvVarsSecret` and `extraEnvVarsConfigMap` has the form `envVarName`, `key`, `name`
(variable name, key in the Secret/ConfigMap, name of the Secret/ConfigMap). They are rendered even when `envs` is empty.
Values of `envs` are always rendered as strings.

### Secrets

| Name             | Description                                                                  | Value   |
|------------------|------------------------------------------------------------------------------|---------|
| `secrets.enabled`| Create a Secret from `secrets.values` and inject it with `envFrom`           | `false` |
| `secrets.values` | Map of keys and values stored in the Secret                                  | `{}`    |

### Ingress

| Name                  | Description                                          | Value                   |
|-----------------------|------------------------------------------------------|-------------------------|
| `ingress.enabled`     | Create an Ingress                                    | `false`                 |
| `ingress.className`   | `ingressClassName` (omitted when empty)              | ``                      |
| `ingress.host`        | Host of the rule, `app.name` when empty              | ``                      |
| `ingress.path`        | Path of the rule                                     | `/`                     |
| `ingress.pathType`    | `Prefix`, `Exact` or `ImplementationSpecific`        | `Prefix`                |
| `ingress.servicePort` | Name of the Service port the Ingress routes to       | `http`                  |
| `ingress.annotations` | Ingress annotations                                  | `{}`                    |
| `ingress.tls`         | Ingress TLS configuration (list as in the Ingress API) | `[]`                  |
