#!/usr/bin/env bash
# Renders each chart with several value sets and validates the manifests
# against the Kubernetes (and OpenShift Route) JSON schemas with kubeconform.
set -euo pipefail

K8S_VERSION="${K8S_VERSION:-1.31.0}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
KUBECONFORM="${KUBECONFORM:-kubeconform}"
CRD_SCHEMAS='https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/openshift/v4.15-strict/{{.ResourceKind}}_{{.Group}}_{{.ResourceAPIVersion}}.json'

validate() {
  local chart="$1" name="$2" kinds="$3"
  shift 3
  echo "==> ${chart} (${name})"
  local rendered
  rendered="$(helm template test "${ROOT}/charts/${chart}" "$@")"
  echo "${rendered}" | "${KUBECONFORM}" -strict -summary \
    -kubernetes-version "${K8S_VERSION}" \
    -schema-location default -schema-location "${CRD_SCHEMAS}"
  local actual
  actual="$(echo "${rendered}" | grep -E '^kind: ' | sed 's/kind: //' | sort | tr '\n' ' ')"
  if [ "${actual}" != "${kinds} " ]; then
    echo "Unexpected kinds for ${chart} (${name}): '${actual}', expected '${kinds} '" >&2
    exit 1
  fi
}

validate spring-boot-api-app defaults "Deployment Service"
validate spring-boot-api-app full "Deployment Ingress Secret Service" \
  --set ingress.enabled=true --set ingress.className=nginx --set ingress.host=api.example.com \
  --set 'ingress.tls[0].secretName=api-tls' --set 'ingress.tls[0].hosts[0]=api.example.com' \
  --set secrets.enabled=true --set secrets.values.KEY=value \
  --set 'extraEnvVarsSecret[0].envVarName=PASS' --set 'extraEnvVarsSecret[0].key=password' --set 'extraEnvVarsSecret[0].name=db' \
  --set 'extraEnvVarsConfigMap[0].envVarName=LEVEL' --set 'extraEnvVarsConfigMap[0].key=level' --set 'extraEnvVarsConfigMap[0].name=cfg'

validate spring-boot-openshift defaults "Deployment Route Service"
validate spring-boot-openshift full "Deployment Route Secret Service" \
  --set route.host=app.example.com --set route.tls.enabled=true \
  --set secrets.enabled=true --set secrets.values.KEY=value \
  --set 'extraEnvVarsSecret[0].envVarName=PASS' --set 'extraEnvVarsSecret[0].key=password' --set 'extraEnvVarsSecret[0].name=db' \
  --set 'extraEnvVarsConfigMap[0].envVarName=LEVEL' --set 'extraEnvVarsConfigMap[0].key=level' --set 'extraEnvVarsConfigMap[0].name=cfg'
validate spring-boot-openshift route-disabled "Deployment Service" --set route.enabled=false
