{{ define "coredns" }}
{{- if .Capabilities.APIVersions.Has "addons.cluster.x-k8s.io/v1beta1/ClusterResourceSet" }}
{{- if eq (include "cluster-shared.clusterresourceset.enabled" .) "true" }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "resource.default.name" . }}-coredns
  namespace: {{ $.Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
data:
  coredns.yml: |
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: coredns
      namespace: kube-system
      labels:
        {{- include "labels.common" . | nindent 8 }}
        app.kubernetes.io/managed-by: Helm
      annotations:
        meta.helm.sh/release-name: coredns
        meta.helm.sh/release-namespace: kube-system
    ---
    kind: NetworkPolicy
    apiVersion: networking.k8s.io/v1
    metadata:
      namespace: kube-system
      name: coredns
      labels:
        {{- include "labels.common" . | nindent 8 }}
        app.kubernetes.io/managed-by: Helm
      annotations:
        meta.helm.sh/release-name: coredns
        meta.helm.sh/release-namespace: kube-system
    spec:
      podSelector:
        matchLabels:
          k8s-app: coredns
      ingress:
      - ports:
        - port: 1053
          protocol: UDP
        - port: 1053
          protocol: TCP
        - port: 53
          protocol: UDP
        - port: 53
          protocol: TCP
      - ports:
        - port: 9153
          protocol: TCP
      egress:
      - {}
      policyTypes:
      - Egress
      - Ingress
    ---
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: coredns-adopter
      namespace: kube-system
      labels:
        {{- include "labels.common" . | nindent 8 }}
    ---
    apiVersion: policy/v1beta1
    kind: PodSecurityPolicy
    metadata:
      name: coredns
      labels:
        {{- include "labels.common" . | nindent 8 }}
        app.kubernetes.io/managed-by: Helm
      annotations:
        meta.helm.sh/release-name: coredns
        meta.helm.sh/release-namespace: kube-system
    spec:
      privileged: false
      allowPrivilegeEscalation: false
      allowedCapabilities:
      - NET_BIND_SERVICE
      volumes:
        - 'configMap'
        - 'emptyDir'
        - 'projected'
        - 'secret'
        - 'downwardAPI'
      hostNetwork: false
      hostIPC: false
      hostPID: false
      runAsUser:
        rule: 'RunAsAny'
      seLinux:
        rule: 'RunAsAny'
      supplementalGroups:
        rule: 'MustRunAs'
        ranges:
          - min: 1
            max: 65535
      fsGroup:
        rule: 'MustRunAs'
        ranges:
          - min: 1
            max: 65535
      readOnlyRootFilesystem: false
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: coredns-psp-user
      labels:
        {{- include "labels.common" . | nindent 8 }}
        app.kubernetes.io/managed-by: Helm
      annotations:
        meta.helm.sh/release-name: coredns
        meta.helm.sh/release-namespace: kube-system
    rules:
    - apiGroups:
      - extensions
      resources:
      - podsecuritypolicies
      resourceNames:
      - coredns
      verbs:
      - use
    ---
    kind: ClusterRoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: coredns-psp
      labels:
        {{- include "labels.common" . | nindent 8 }}
        app.kubernetes.io/managed-by: Helm
      annotations:
        meta.helm.sh/release-name: coredns
        meta.helm.sh/release-namespace: kube-system
    subjects:
    - kind: ServiceAccount
      name: coredns
      namespace: kube-system
    roleRef:
      kind: ClusterRole
      name: coredns-psp-user
      apiGroup: rbac.authorization.k8s.io
    ---
    apiVersion: policy/v1beta1
    kind: PodSecurityPolicy
    metadata:
      name: coredns-adopter
      labels:
        {{- include "labels.common" . | nindent 8 }}
    spec:
      hostNetwork: true
      privileged: false
      allowPrivilegeEscalation: false
      runAsUser:
        ranges:
          - max: 65535
            min: 1000
        rule: MustRunAs
      seLinux:
        rule: RunAsAny
      supplementalGroups:
        rule: 'MustRunAs'
        ranges:
          - min: 1
            max: 65535
      fsGroup:
        rule: 'MustRunAs'
        ranges:
          - min: 1
            max: 65535
      volumes:
      - 'secret'
      - 'configMap'
      hostPID: false
      hostIPC: false
      readOnlyRootFilesystem: false
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: coredns-adopter
      labels:
        {{- include "labels.common" . | nindent 8 }}
    rules:
    - apiGroups: ["", "*"]
      resources: ["*"]
      resourceNames: ["coredns", "coredns-workers", "kube-dns", "system:coredns", "coredns-adopter"]
      verbs: ["*"]
    - apiGroups: ["", "*"]
      resources: ["*"]
      verbs: ["list"]
    - apiGroups: ["apps"]
      resources: ["deployments"]
      verbs: ["create"]
    - apiGroups: [""]
      resources: ["services"]
      verbs: ["create"]
    ---
    kind: ClusterRoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: coredns-adopter
      labels:
        {{- include "labels.common" . | nindent 8 }}
    subjects:
    - kind: ServiceAccount
      name: coredns-adopter
      namespace: kube-system
    roleRef:
      kind: ClusterRole
      name: coredns-adopter
      apiGroup: rbac.authorization.k8s.io
    ---
    kind: ClusterRoleBinding
    apiVersion: rbac.authorization.k8s.io/v1
    metadata:
      name: coredns-adopter-rbac
      labels:
        {{- include "labels.common" . | nindent 8 }}
    subjects:
    - kind: ServiceAccount
      name: coredns-adopter
      namespace: kube-system
    roleRef:
      kind: ClusterRole
      name: system:coredns
      apiGroup: rbac.authorization.k8s.io
    ---
    apiVersion: batch/v1
    kind: Job
    metadata:
      name: coredns-adopter
      namespace: kube-system
      labels:
        {{- include "labels.common" . | nindent 8 }}
      annotations:
        kubernetes.io/description: |
          Runs at cluster creation to label and annotate default, kubeadm installed CoreDNS
          resources so they can be managed by Helm and replaced with our managed app.
    spec:
      backoffLimit: 0
      template:
        metadata:
          name: coredns-adopter
          labels:
            {{- include "labels.common" . | nindent 12 }}
          annotations:
            kubernetes.io/description: |
              Runs at cluster creation to label and annotate default, kubeadm installed CoreDNS
              resources so they can be managed by Helm and replaced with our managed app.
        spec:
          restartPolicy: Never
          serviceAccountName: coredns-adopter
          tolerations:
          - operator: Exists
          hostNetwork: true # No need to wait for CNI to be ready
          containers:
          - name: kubectl
            image: "{{ include "cluster-shared.kubectl-image" . }}"
            command:
            - bash
            - -c
            - |
              sleep 60

              function patchResource() {
                if kubectl get $@ &>/dev/null; then
                  echo "Patching resource ${1}"
                  kubectl annotate --overwrite $@ meta.helm.sh/release-name=coredns
                  kubectl annotate --overwrite $@ meta.helm.sh/release-namespace=kube-system
                  kubectl label --overwrite $@ app.kubernetes.io/managed-by=Helm
                  kubectl label --overwrite $@ k8s-app=coredns
                else
                  echo "resource ${1} doesn't exist!"
                fi
              }

              echo "Patching existing coredns resources..."
              patchResource netpol/coredns -n kube-system
              patchResource configmap/coredns -n kube-system
              patchResource serviceaccount/coredns -n kube-system
              patchResource service/kube-dns -n kube-system
              patchResource deployment/coredns -n kube-system
              patchResource clusterrole/system:coredns
              patchResource clusterrolebinding/system:coredns
              echo "Finished patching"

              # Change port specified in Corefile config
              kubectl -n kube-system get configmap coredns -o yaml | sed 's/\.:53/\.:1053/' | kubectl apply -f -

              echo "Updating coredns service..."
              kubectl -n kube-system get service kube-dns -o json \
                | jq '.metadata.name="coredns"' \
                | jq '(. | .spec.ports[] | select(.targetPort==53)).targetPort |= 1053' \
                | jq '.spec.selector."k8s-app"="coredns"' \
                | jq 'del(.status, .metadata.uid, .metadata.resourceVersion, .metadata.generation, .metadata.creationTimestamp)' \
                | tee /tmp/svc.yaml
              kubectl -n kube-system delete service kube-dns
              kubectl apply -f /tmp/svc.yaml
              echo "Finished updating coredns service"

              echo "Updating coredns deployment..."
              kubectl -n kube-system get deployment coredns -o json \
                | jq '.metadata.name="coredns-workers"' \
                | jq '(. | .spec.template.spec.containers[0].ports[] | select(.containerPort==53)).containerPort |= 1053' \
                | jq '.metadata.labels."app.kubernetes.io/component"="workers"' \
                | jq '.spec.template.metadata.labels."app.kubernetes.io/component"="workers" | .spec.template.metadata.labels."k8s-app"="coredns"' \
                | jq '.spec.selector.matchLabels."app.kubernetes.io/component"="workers" | .spec.selector.matchLabels."k8s-app"="coredns"' \
                | jq '.spec.template.spec.containers[0].args += ["-dns.port", "1053"]' \
                | jq 'del(.status, .metadata.uid, .metadata.resourceVersion, .metadata.generation, .metadata.creationTimestamp)' \
                | tee /tmp/dep.yaml
              kubectl -n kube-system delete deployment coredns
              kubectl apply -f /tmp/dep.yaml
              echo "Finished updating coredns deployment"

              echo "CoreDNS adoption complete!"
---
apiVersion: addons.cluster.x-k8s.io/v1beta1
kind: ClusterResourceSet
metadata:
  name: {{ include "resource.default.name" . }}-coredns
  namespace: {{ $.Release.Namespace }}
  labels:
    {{- include "labels.common" . | nindent 4 }}
spec:
  clusterSelector:
    matchLabels:
      {{- include "labels.selector" . | nindent 6 }}
  resources:
  - kind: ConfigMap
    name: {{ include "resource.default.name" . }}-coredns
---
{{- end -}}
{{- end -}}
{{ end }}
