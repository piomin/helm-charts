# Helm Chart for Spring Boot REST App

## Parameters

### Image parameters

| Name                | Description                                                                | Value                |
| ------------------- | ---------------------------------------------------------------------------| -------------------- |
| `image.repository`  | Image repository                                                           | ``                   |
| `image.tag`         | Image tag (immutable tags are recommended)                                 | `1.0`                |

### Application parameters

| Name                | Description                                                                | Value                |
| ------------------- | ---------------------------------------------------------------------------| -------------------- |
| `app.name`          | The name of deployment                                                     | `sample-spring-boot` |
| `app.environment`   | The value of `env` label                                                   | `dev`                |
| `app.owner`         | The value of `owner` label                                                 | ``                   |