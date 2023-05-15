#!/bin/sh

#@ Disable shellcheck rules that are not needed or that cause false positives
# SC1090: ignore "source file not found" warnings
# SC2034: ignore unused variable warnings for environment variables
# SC2154: ignore undeclared variable warnings for environment variables
# shellcheck disable=SC1090,SC2034,SC2154

#@ Allow external access to environment variables
set -o allexport

#@ Set the working directory to the directory containing the script
workspace="$PWD"

#@ Load environment variables from .env file
dotenv="$workspace/.env"
if [ -f "$dotenv" ]; then
  . "$dotenv"
else
  printf "Please create a .env file with the following variables:\n"
  printf "  host, port, user, db\n"
  exit 1
fi

#@ Enable local scripts
[ "$bin" ] || bin="$project/Bin"
  find "$bin" -type f -exec chmod +x {} \;

#@ Enable archive
[ "$archive" ] || archive="$project/Bin"

#@ Execute the scripts
"$bin"/get_sql
# "$bin"/init_db

#@ Disable external access to environment variables
set +o allexport

#@ Unset variables that were only needed during this script
unset \
  project \
  project_name \
  archive \
  bin \
  host \
  port \
  user \
  db
