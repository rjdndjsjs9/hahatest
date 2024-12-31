# Base image dengan dukungan grafis
FROM ubuntu:20.04

# Set timezone
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update sistem dan install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    gnupg \
    xvfb \
    fluxbox \
    x11vnc \
    novnc \
    curl \
    google-chrome-stable \
    dbus-x11 \
    sudo

# Tambahkan Google Chrome repository dan install Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Install NoVNC untuk akses browser melalui web
RUN wget https://github.com/novnc/noVNC/archive/refs/heads/master.zip && \
    unzip master.zip && \
    mv noVNC-master /opt/novnc

# Copy script startup
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port untuk VNC dan NoVNC
EXPOSE 8080 5900

# Jalankan script
CMD ["/start.sh"]
