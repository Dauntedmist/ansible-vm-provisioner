# Use Debian Trixie (Testing) as the base
FROM debian:trixie

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install necessary packages for Dev/Ansible
# - openssh-server: For Vagrant/SSH access
# - sudo: Required for Vagrant and Ansible escalation
# - python3: Required for Ansible to run on the target
# - systemctl/iproute2: Helpful for networking and service management
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    iproute2 \
    curl \
    vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Configure SSH
# Allow password authentication (Vagrant's default initial method)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 3. Create the 'vagrant' user
RUN useradd -m -s /bin/bash vagrant && \
    echo "vagrant:vagrant" | chpasswd && \
    echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant

# 4. Install Vagrant's insecure public key
# This allows 'vagrant up' to connect without manual password entry
RUN mkdir -p /home/vagrant/.ssh && \
    chmod 700 /home/vagrant/.ssh && \
    curl -L https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub \
    -o /home/vagrant/.ssh/authorized_keys && \
    chmod 600 /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant:vagrant /home/vagrant/.ssh

# Standard SSH port
EXPOSE 22

# Start the SSH daemon
CMD ["/usr/sbin/sshd", "-D"]