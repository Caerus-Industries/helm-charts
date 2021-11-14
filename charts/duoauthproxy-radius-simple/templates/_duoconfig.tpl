{{/*
Duo Authentication Proxy Duo-Only Radius Server Configuration Template
*/}}
{{- define "duoauthproxy-radius-simple.config" -}}
[main]
debug={{ .Values.duo.debug }}
log_stdout=true

[radius_server_duo_only]
ikey=<duo_ikey>
skey=<duo_skey>
api_host={{ .Values.duo.apiHost }}
radius_ip_1=<radius_ip>
radius_secret_1=<radius_secret>
failmode={{ .Values.duo.failmode }}
{{- end }}