#!/bin/bash

# Jalankan Xvfb untuk tampilan grafis
Xvfb :99 -screen 0 1920x1080x24 &

# Jalankan Fluxbox sebagai window manager
fluxbox &

# Jalankan x11vnc untuk remote desktop
x11vnc -display :99 -forever -nopw -rfbport 5900 &

# Jalankan NoVNC untuk akses browser melalui web
/opt/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080 &

# Jalankan Google Chrome di layar virtual
google-chrome --no-sandbox --disable-dev-shm-usage --start-maximized --display=:99 &

# Menjaga container tetap berjalan
tail -f /dev/null
