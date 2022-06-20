
{{- define "cluster-shared.clusterresourceset.enabled" -}}
{{ .Values.includeClusterResourceSet | default true }}
{{- end }}

{{- define "cluster-shared.kubectl-image" -}}
{{- $kubectlRegistry := "quay.io" -}}
{{- $kubectlName := "giantswarm/kubectl" -}}
{{- $kubectlTag := "1.24.1" -}}
{{- if not .Values.kubectlImage }}
quay.io/giantswarm/kubectl:1.23.5
{{- else }}
{{ .Values.kubectlImage.registry | default $kubectlRegistry }}/{{ .Values.kubectlImage.name | default $kubectlName }}:{{ .Values.kubectlImage.tag | default $kubectlTag}}
{{- end }}
{{- end }}
