# Use Debian Trixie (Testing) as the base
FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install necessary packages including systemd
RUN apt-get update && apt-get install -y \
    systemd \
    systemd-sysv \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    iproute2 \
    curl \
    vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Cleanup systemd to run inside a container
# We remove unnecessary units that try to access hardware or kernel features
RUN find /lib/systemd/system/sysinit.target.wants/ -name "systemd-tmpfiles-setup*" -delete; \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# 3. Configure SSH (ensure the service starts via systemd)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    systemctl enable ssh

# 4. Create the 'vagrant' user
RUN useradd -m -s /bin/bash vagrant && \
    echo "vagrant:vagrant" | chpasswd && \
    echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant

# 5. Install Vagrant's insecure public key
RUN mkdir -p /home/vagrant/.ssh && \
    chmod 700 /home/vagrant/.ssh && \
    curl -L https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub \
    -o /home/vagrant/.ssh/authorized_keys && \
    chmod 600 /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant:vagrant /home/vagrant/.ssh

# Required for systemd to know it's in a container
ENV container=docker

# Standard SSH port
EXPOSE 22

# Systemd expects this signal to shut down correctly
STOPSIGNAL SIGRTMIN+3

# Start systemd as the init process
CMD ["/lib/systemd/systemd"]