FROM ubuntu:22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    perl \
    make \
    gcc \
    linux-headers-generic \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /tmp

# Download MLNX_OFED package
RUN wget https://content.mellanox.com/ofed/MLNX_OFED-24.10-2.1.8.0/MLNX_OFED_LINUX-24.10-2.1.8.0-ubuntu22.04-x86_64.tgz

# Extract the package
RUN tar -xvf MLNX_OFED_LINUX-24.07-0.6.1.0-ubuntu22.04-x86_64.tgz

# Set working directory to the extracted folder
WORKDIR /tmp/MLNX_OFED_LINUX-24.07-0.6.1.0-ubuntu22.04-x86_64

# You can add additional commands here to install the package if needed
# For example:
RUN ./mlnxofedinstall --user-space-only --without-fw-update --force

# Clean up
RUN rm -rf /tmp/MLNX_OFED_LINUX-24.07-0.6.1.0-ubuntu22.04-x86_64.tgz

# Set default command
CMD ["/bin/bash"]