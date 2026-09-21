{{- define "vmtroubleshoot.registryHost" -}}
vm-registry.{{ .Values.registry.namespace }}.svc.cluster.local:5000
{{- end -}}
