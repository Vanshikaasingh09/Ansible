# Use Ubuntu as base
FROM ubuntu:20.04

# Disable interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install openssh-server, python3, pip
RUN apt-get update && \
    apt-get install -y openssh-server python3 python3-pip && \
    mkdir /var/run/sshd && \
    rm -rf /var/lib/apt/lists/*

# Create SSH directory for root
RUN mkdir -p /root/.ssh

# Copy public key into authorized_keys
COPY id_rsa_ansible.pub /root/.ssh/authorized_keys

# Set correct permissions
RUN chmod 600 /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh

# Expose SSH port
EXPOSE 22

# Run SSH server
CMD ["/usr/sbin/sshd", "-D"]
