#!/usr/bin/env python3
import json
import subprocess

clients_raw = subprocess.check_output(["hyprctl", "clients", "-j"])
clients = json.loads(clients_raw)

output = []
for c in clients:
    if c.get("mapped", False):
        pid = c["pid"]
        title = c["title"] or c["class"]
        output.append(f"{title} ({pid})")

print(" | ".join(output))

