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
  # exit 1
fi
