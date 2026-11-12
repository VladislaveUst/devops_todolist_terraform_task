#!/bin/bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
app_dir=/app
export DEBIAN_FRONTEND=noninteractive
apt-get -q -o Acquire::Retries=3 update
apt-get -qy -o DPkg::Lock::Timeout=120 -o Acquire::Retries=3 install python3-venv unzip curl

if ! id todoapp >/dev/null 2>&1; then
    useradd --system --no-create-home --shell /usr/sbin/nologin todoapp
fi

install -d "$app_dir"
unzip -oq "$script_dir/todolist-app.zip" -d "$app_dir"
python3 -m venv "$app_dir/.venv"
"$app_dir/.venv/bin/python" -m pip install -r "$app_dir/requirements.txt"
chown -R todoapp:todoapp "$app_dir"

if [[ ! -f /etc/todoapp.env ]]; then
    (
        umask 077
        printf 'DJANGO_SECRET_KEY=%s\nDJANGO_DEBUG=0\n' "$(python3 -c 'import secrets; print(secrets.token_urlsafe(48))')" > /etc/todoapp.env
    )
fi

sed 's/\r$//' "$app_dir/todoapp.service" > /etc/systemd/system/todoapp.service
systemctl daemon-reload
systemctl enable todoapp.service
systemctl restart todoapp.service
curl -fsS --retry 15 --retry-connrefused --retry-delay 2 --max-time 5 http://127.0.0.1:8080/ >/dev/null
