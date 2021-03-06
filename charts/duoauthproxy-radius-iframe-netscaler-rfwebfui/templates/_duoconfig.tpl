{{/*
Duo Authentication Proxy Duo-Only Radius Server Configuration Template
*/}}
{{- define "duoauthproxy-radius-simple.config" -}}
[main]
debug={{ .Values.duo.debug }}
log_stdout=true

[duo_only_client]

[radius_server_iframe]
type=citrix_netscaler_rfwebui
client=duo_only_client
ikey=<duo_ikey>
skey=<duo_skey>
api_host={{ .Values.duo.apiHost }}
radius_ip_1=<radius_ip>
radius_secret_1=<radius_secret>
failmode={{ .Values.duo.failmode }}
{{- end }}


