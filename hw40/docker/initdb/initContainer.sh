#!/bin/bash

echo "Начало Bash скриптов"

cat /proc/version
apt update
apt install mongodb-org-shell
mongosh --version

echo "Конец Bash скриптов"