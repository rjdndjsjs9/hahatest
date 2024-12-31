# Menggunakan base image Linux
FROM ubuntu:20.04

# Set timezone non-interaktif
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update sistem dan install dependencies
RUN apt-get update && apt-get install -y \
    ttyd \
    curl \
    wget \
    nano \
    vim \
    unzip \
    git \
    openssh-server \
    sudo

# Install code-server (VSCode di browser)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Konfigurasi direktori kerja
WORKDIR /root

# Tambahkan user untuk akses root tanpa batas
RUN echo "root:root" | chpasswd

# Buat direktori untuk upload/download file
RUN mkdir /root/files

# Expose port 8080 untuk ttyd (terminal) dan 8081 untuk code-server
EXPOSE 8080 8081

# Jalankan ttyd dan code-server secara paralel
CMD ttyd -p 8080 bash & \
    code-server --bind-addr 0.0.0.0:8081 --auth none --disable-telemetry --user-data-dir /root/files && \
    tail -f /dev/null
