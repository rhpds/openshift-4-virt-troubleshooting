{{- define "vmtroubleshoot.registryHost" -}}
vm-registry.{{ .Values.registry.namespace }}.svc.cluster.local:5000
{{- end -}}

{{/*
Externally-resolvable host for the registry's Route. Node-level CRI-O image
pulls (containerDisk) use the node's own DNS, which cannot resolve the
in-cluster Service DNS above -- confirmed live (2026-09-21), every worker
failed with "no such host" pulling via vmtroubleshoot.registryHost. Pod-level
consumers (e.g. the image-sync Job in this chart) should keep using
vmtroubleshoot.registryHost instead; only node-level pulls need this.
*/}}
{{- define "vmtroubleshoot.registryExternalHost" -}}
vm-registry.{{ .Values.deployer.domain }}
{{- end -}}
