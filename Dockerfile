FROM ubuntu:22.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Define MLNX_OFED version and package information as variables
ENV MLNX_OFED_VERSION="24.10-2.1.8.0"
ENV MLNX_OFED_OS="ubuntu22.04-x86_64"
ENV MLNX_OFED_PACKAGE="MLNX_OFED_LINUX-${MLNX_OFED_VERSION}-${MLNX_OFED_OS}"

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

# Download MLNX_OFED package using the variables
RUN wget https://content.mellanox.com/ofed/MLNX_OFED-${MLNX_OFED_VERSION}/${MLNX_OFED_PACKAGE}.tgz

# Extract the package
RUN tar -xvf ${MLNX_OFED_PACKAGE}.tgz

# Set working directory to the extracted folder
WORKDIR /tmp/${MLNX_OFED_PACKAGE}

# You can add additional commands here to install the package if needed
# For example:
# RUN ./mlnxofedinstall --user-space-only --without-fw-update --force

# Clean up
RUN rm -rf /tmp/${MLNX_OFED_PACKAGE}.tgz

# Set default command
CMD ["/bin/bash"]