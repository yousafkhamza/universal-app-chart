{{- define "universal-app.name" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else if .Values.nameOverride -}}
{{- .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "universal-app.fullname" -}}
{{ include "universal-app.name" . }}
{{- end -}}

{{- define "universal-app.chartname" -}}
universal-app
{{- end -}}