
{{- define "swift-convert-api.name" -}}
{{- default .Chart.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "swift-convert-api.fullname" -}}
{{- if .Values.api.fullnameOverride }}
{{- .Values.api.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.api.fullnameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
API labels
*/}}
{{- define "swift-convert-api.labels" -}}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{ include "swift-convert-api.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "swift-convert-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "swift-convert-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "swift-convert-api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "swift-convert-api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}
