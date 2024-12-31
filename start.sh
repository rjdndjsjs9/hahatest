#!/bin/bash

# Jalankan ttyd (web terminal)
ttyd -p 8080 bash &

# Jalankan code-server (web editor)
code-server --bind-addr 0.0.0.0:8081 --auth none --disable-telemetry --user-data-dir /root/files &

# Menjaga container tetap berjalan
tail -f /dev/null
