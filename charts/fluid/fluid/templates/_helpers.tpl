{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fluid.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fluid.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fluid.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "fluid.labels" -}}
helm.sh/chart: {{ include "fluid.chart" . }}
{{ include "fluid.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "fluid.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fluid.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "fluid.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "fluid.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*relace registry to registry-vpc
*/}}
{{- define "fluid.imageTransform" -}}
{{- $image := index . 0 -}}
{{- $tag := index . 1 -}}
{{- $isPullImageByVpc := true -}}
{{- $isAppendTag := true -}}
{{- $argLen := len . -}}
{{- if gt $argLen 2 -}}
{{- $isPullImageByVpc = index . 2 -}}
{{- $isAppendTag = index . 3 -}}
{{- end -}}
{{- if and $isAppendTag $tag -}}
{{- $image = printf "%s:%s" $image $tag -}}
{{- end -}}
{{- if $isPullImageByVpc -}}
"{{ $image | replace "registry." "registry-vpc." }}"
{{- else -}}
"{{ $image }}"
{{- end -}}
{{- end -}}
