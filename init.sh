#!/bin/sh

# init_env() {
#   #@ Allow external access to environment variables
#   set -o allexport

#   #@ Declare variables
#   bin="$workspace/bin"
#   log="$workspace/log"
#   pg_log="$log/PostgreSQL.log"
#   PGDATA=".data"
#   PATH="$PATH:$bin"

#   #@ Disable external access to environment variables
#   set +o allexport
# }

# init_scripts() {
#   [ -d "$bin" ] || return 1

#   #@ Enable any non-executable scripts
#   find "$bin" -type f ! -executable -exec chmod +x {} \;

#   #@ Append scripts to PATH for efficienct calling

#   #@ Execute scripts
#   ls
#   testir
# }

init_env
init_scripts
