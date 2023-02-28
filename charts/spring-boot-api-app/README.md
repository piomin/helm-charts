# Helm Chart for Spring Boot REST App

## Parameters

### General

| Name           | Description                                 | Value |
|----------------|---------------------------------------------|-------|
| `replicaCount` | Number of replicas                          | 1     |
| `envs`         | List of environment variables (name, value) | []    |
| `ports`        | List of exposed ports (name, value)         | []    |

### Image parameters

| Name                | Description                                                  | Value                |
|---------------------|--------------------------------------------------------------|----------------------|
| `image.repository`  | Image repository                                             | ``                   |
| `image.tag`         | Image tag (immutable tags are recommended)                   | `1.0`                |

### Application parameters

| Name                | Description                                                  | Value                |
|---------------------|--------------------------------------------------------------|----------------------|
| `app.name`          | The name of deployment                                       | `sample-spring-boot` |
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
| `resources.limits.cpu`      | Limit for CPU      | `1000Mi` |
| `resources.limits.memory`   | Limit for memory   | `512Mi`  |
| `resources.requests.cpu`    | Request for CPU    | `100Mi`  |
| `resources.requests.memory` | Request for memory | `256Mi`  | 

### Liveness probe

| Name                           | Description                                       | Value                       |
|--------------------------------|---------------------------------------------------|-----------------------------|
| `liveness.initialDelaySeconds` | Number of seconds after the container             | 10                          |
| `liveness.port`                | The value of `env` label                          | `http`                      |
| `liveness.path`                | The value of `owner` label                        | `/actuator/health/liveness` |
| `liveness.timeoutSeconds`      | Number of seconds after which the probe times out | 5                           | 
| `liveness.failureThreshold`    | Number of max failures in row                     | 3                           | 
| `liveness.successThreshold`    | Minimum consecutive successes to be successful    | 1                           | 
| `liveness.periodSeconds`       | How often (in seconds) to perform the probe       | 5                           |

### Readiness probe

| Name                             | Description                                       | Value                        |
|----------------------------------|---------------------------------------------------|------------------------------|
| `readiness.initialDelaySeconds`  | Number of seconds after the container             | 10                           |
| `readiness.port`                 | The value of `env` label                          | `http`                       |
| `readiness.path`                 | The value of `owner` label                        | `/actuator/health/readiness` |
| `readiness.timeoutSeconds`       | Number of seconds after which the probe times out | 5                            | 
| `readiness.failureThreshold`     | Number of max failures in row                     | 3                            | 
| `readiness.successThreshold`     | Minimum consecutive successes to be successful    | 1                            | 
| `readiness.periodSeconds`        | How often (in seconds) to perform the probe       | 5                            |