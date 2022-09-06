
{{- define "cluster-shared.clusterresourceset.enabled" -}}
{{ .Values.includeClusterResourceSet | default true }}
{{- end }}

{{- define "cluster-shared.kubectl-image" -}}
{{- $kubectlImageRegistry := "quay.io" -}}
{{- $kubectlImageName := "giantswarm/kubectl" -}}
{{- $kubectlImageTag := "1.24.1" -}}
{{ .Values.kubectlImage.registry | default $kubectlImageRegistry }}/{{ .Values.kubectlImage.name | default $kubectlImageName }}:{{ .Values.kubectlImage.tag | default $kubectlImageTag}}
{{- end }}
