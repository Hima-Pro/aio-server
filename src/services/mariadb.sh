#!/sbin/openrc-run

depend() {
    need net
}

name="mariadb"
description="mariadb sql server"

command="/usr/bin/mysqld"
command_args="--user=mysql --console --skip-name-resolve --skip-networking=0"
command_background=true

pidfile="/app/pids/${RC_SVCNAME}.pid"

output_log="/app/logs/${RC_SVCNAME}.log"
error_log="/app/logs/${RC_SVCNAME}.log"