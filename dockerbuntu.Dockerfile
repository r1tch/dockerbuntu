# Use the official Ubuntu base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update apt and install packages
RUN apt update && apt upgrade -y && apt install -y \
    ssh \
    cron \
    lsb-core \
    vim \
    python3 \
    bash \
    bash-completion \
    sudo \
    curl \
    wget \
    git \
    net-tools \
    lsb-release \
    ca-certificates \
    software-properties-common \
    byobu \
    dnsutils \
    bind9-host \
    netcat \
    zip \
    7zip \
    fish \
    unison \
    bpytop \
 && rm -rf /var/lib/apt/lists/*

# Setup SSH
RUN mkdir /var/run/sshd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# we want nice colored prompts :)
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /root/.bashrc
# re-installing all the man pages - as man pages are an essential part of a proper Linux installation
RUN echo y | unminimize

# Copy the startup script into the image
COPY dockerbuntu.sh /usr/local/bin/dockerbuntu.sh
RUN chmod +x /usr/local/bin/dockerbuntu.sh

# Expose the SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/local/bin/dockerbuntu.sh"]
