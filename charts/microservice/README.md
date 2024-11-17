# Helm Chart of microservice

## Parameters

### Kubernetes Parameters

This section contains parameters common to most of the Helm Charts in the wild
Pod Spec, Service, Ingress, Persistence etc.

| Name                                         | Description                                                                                                          | Value          |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | -------------- |
| `replicaCount`                               | Number of replicas to deploy                                                                                         | `1`            |
| `image.repository`                           | Image repository                                                                                                     | `microservice` |
| `image.tag`                                  | Image tag. Overrides the image tag whose default is the chart appVersion. (default to "master" before first release) | `latest`       |
| `image.pullPolicy`                           | Specify a imagePullPolicy                                                                                            | `IfNotPresent` |
| `image.pullSecrets`                          | Specify docker-registry secret names as an array                                                                     | `[]`           |
| `nameOverride`                               | String to be used in labels                                                                                          | `""`           |
| `fullnameOverride`                           | String to be used as the base of most resource names                                                                 | `""`           |
| `serviceAccount.create`                      | Create a ServiceAccount                                                                                              | `false`        |
| `serviceAccount.annotations`                 | Annotations to add to the service account                                                                            | `{}`           |
| `serviceAccount.name`                        | The name of the service account to use.                                                                              | `""`           |
| `podAnnotations`                             | Annotations of microservice pod                                                                                      | `{}`           |
| `securityContext`                            | Security Context of microservice container                                                                           | `{}`           |
| `service.type`                               | type of service                                                                                                      | `ClusterIP`    |
| `service.ports`                              | key value of ports. Valid keys are http, grpc, websocket & healthcheck                                               | `nil`          |
| `ingress.enabled`                            | Enable ingress                                                                                                       | `false`        |
| `ingress.annotations`                        | annotations of ingress                                                                                               | `{}`           |
| `ingress.hosts`                              | hosts of ingress                                                                                                     | `[]`           |
| `ingress.tls`                                | TLS setting of ingress                                                                                               | `[]`           |
| `resources`                                  | Resource settings of microservice container                                                                          | `{}`           |
| `autoscaling.enabled`                        | enable autoscaling                                                                                                   | `false`        |
| `autoscaling.minReplicas`                    | minimum replicas                                                                                                     | `1`            |
| `autoscaling.maxReplicas`                    | maximum replicas                                                                                                     | `5`            |
| `autoscaling.targetCPUUtilizationPercentage` | target CPU utilization percentage                                                                                    | `75`           |
| `nodeSelector`                               | nodeSelector of pod                                                                                                  | `{}`           |
| `tolerations`                                | tolerations of pod                                                                                                   | `[]`           |
| `affinity`                                   | affinity of pod                                                                                                      | `{}`           |
| `configMapEnv`                               | values to be used as containers env vars                                                                             | `{}`           |
| `secretEnv`                                  | sensitive values to be used as containers env vars                                                                   | `{}`           |
| `configMapVolume.enabled`                    | Enable configMapVolume                                                                                               | `false`        |
| `secretVolume.enabled`                       | Enable secretVolume                                                                                                  | `false`        |
| `volumes`                                    | Custom mount paths for additional volumes                                                                            | `[]`           |
| `clusterRoleBinding.enabled`                 | Enable clusterRoleBinding                                                                                            | `false`        |
| `clusterRole.enabled`                        | Enable clusterRole                                                                                                   | `false`        |
| `serviceMonitor.enabled`                     | Enable serviceMonitor                                                                                                | `false`        |
| `serviceMonitor.port`                        | name of the port used in service                                                                                     | `healthcheck`  |
| `serviceMonitor.path`                        | path of the metrics endpoint                                                                                         | `/metrics`     |
| `serviceMonitor.interval`                    | interval of the metrics scraping                                                                                     | `30s`          |
| `networkPolicy.enabled`                      | Enable networkPolicy                                                                                                 | `false`        |
