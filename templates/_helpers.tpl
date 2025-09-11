{{/*
Expand the name of the chart.
*/}}
{{- define "deploio.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" | replace "_" "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "deploio.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" | replace "_" "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride | replace "_" "-" }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" | replace "_" "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
Safe for Kubernetes labels.
*/}}
{{- define "deploio.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version 
    | replace "+" "_" 
    | replace "^\\." "" 
    | replace "_$" "" 
    | trunc 63 
    | trimSuffix "-" 
}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "deploio.labels" -}}
helm.sh/chart: {{ include "deploio.chart" . }}
{{ include "deploio.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "deploio.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploio.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "deploio.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "deploio.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
