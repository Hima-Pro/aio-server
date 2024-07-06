#!/sbin/openrc-run

depend() {
    need net
}

name="apache2"
description="Apache2 web server"

command="/usr/sbin/httpd"
command_args="-D FOREGROUND"
command_background=true

pidfile="/app/pids/${RC_SVCNAME}.pid"

output_log="/app/logs/${RC_SVCNAME}.log"
error_log="/app/logs/${RC_SVCNAME}.log"