{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-shared.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cluster-shared.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "cluster-shared.labels.common" -}}
app: {{ include "cluster-shared.name" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.Version | quote }}
cluster.x-k8s.io/cluster-name: {{ include "cluster-shared.resource.default.name" . | quote }}
giantswarm.io/cluster: {{ include "cluster-shared.resource.default.name" . | quote }}
giantswarm.io/organization: {{ .Values.global.organization | quote }}
helm.sh/chart: {{ include "cluster-shared.chart" . | quote }}
{{- end -}}

{{/*
Create a name stem for resource names
When resources are created from templates by Cluster API controllers, they are given random suffixes.
Given that Kubernetes allows 63 characters for resource names, the stem is truncated to 47 characters to leave
room for such suffix.
*/}}
{{- define "cluster-shared.resource.default.name" -}}
{{ required "Please provide a clusterName value" .Values.global.clusterName }}
{{- end -}}
