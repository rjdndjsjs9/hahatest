# Base image Ubuntu
FROM ubuntu:20.04

# Set timezone
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Non-interaktif untuk instalasi paket
ENV DEBIAN_FRONTEND=noninteractive

# Update dan install dependencies dasar
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    gnupg \
    xvfb \
    fluxbox \
    x11vnc \
    dbus-x11 \
    sudo

# Tambahkan repository Google Chrome dan key
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Update repository dan install Google Chrome
RUN apt-get update && apt-get install -y google-chrome-stable --no-install-recommends

# Install NoVNC untuk akses browser melalui web
RUN wget https://github.com/novnc/noVNC/archive/refs/heads/master.zip && \
    unzip master.zip && \
    mv noVNC-master /opt/novnc

# Tambahkan user untuk akses root
RUN echo "root:root" | chpasswd

# Copy script startup
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port untuk VNC dan NoVNC
EXPOSE 8080 5900

# Jalankan script
CMD ["/start.sh"]
