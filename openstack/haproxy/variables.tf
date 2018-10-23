variable "quantity" {
  default = 1
}

variable "name" {
  default = "haproxy"
}

variable "sec_group" {
  type = "list"
}

variable "keypair" {
}

variable "flavor" {
  default = "e3standard.x2"
}

variable "external" {
  default = "false"
}

variable "network_name" {
}

variable "image" {
  default = "ecs-haproxy 1.1.5"
}

variable "discovery" {
  default = "true"
}

variable "region" {
  default = "it-mil1"
}

variable "haproxy_user" {
}

variable "haproxy_pass" {
}

variable "haproxy_global" {
  default = <<EOF
  global
      log /dev/log local0
      log /dev/log local1 notice
      chroot /var/lib/haproxy
      stats socket /run/haproxy/admin.sock mode 660 level admin
      stats timeout 30s
      user haproxy
      group haproxy
      daemon
      maxconn 200000
      nbproc "{{ ansible_processor_vcpus }}"
  {% for n in range(ansible_processor_vcpus) %}
      cpu-map {{ n + 1 }} {{ n }}
  {% endfor %}
      ca-base /etc/ssl/certs
      crt-base /etc/ssl/private
      ssl-default-bind-ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS:!3DES
      ssl-default-bind-options no-sslv3
      tune.ssl.default-dh-param 2048
      EOF
  
}

variable "haproxy_defaults" {
  default = <<EOF
    defaults
      option log-health-checks
      mode    http
      option  dontlognull
      timeout connect 8000
      timeout client  60000
      timeout server  60000
      errorfile 400 /etc/haproxy/errors/400.http
      errorfile 403 /etc/haproxy/errors/403.http
      errorfile 408 /etc/haproxy/errors/408.http
      errorfile 500 /etc/haproxy/errors/500.http
      errorfile 502 /etc/haproxy/errors/502.http
      errorfile 503 /etc/haproxy/errors/503.http
      errorfile 504 /etc/haproxy/errors/504.http
      EOF
}

variable "haproxy_stats" {
  default = <<EOF
    listen stats
      bind *:8282
      mode http
      stats enable
      stats uri /
      stats realm Haproxy\ Statistics
      stats show-desc "HAProxy WebStatistics"
      stats show-node
      stats show-legends
      stats auth {{ haproxy_user }}:{{ haproxy_pass }}
      stats admin if TRUE
  EOF
}

variable "haproxy_conf" {
}

variable "consul" {
  default = ""
}

variable "consul_port" {
  default = "8500"
}

variable "consul_datacenter" {
}

variable "consul_encrypt" {
}

variable "haproxy_cert" {
}
