#!/sbin/openrc-run

depend() {
    need net
}

name="phpmyadmin"
description="phpmyadmin web server"

command="/usr/bin/php"
command_args="-S 0.0.0.0:8080 -t /usr/share/webapps/phpmyadmin"
command_background=true

pidfile="/app/pids/${RC_SVCNAME}.pid"

output_log="/app/logs/${RC_SVCNAME}.log"
error_log="/app/logs/${RC_SVCNAME}.log"