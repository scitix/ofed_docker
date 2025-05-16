# MLNX_OFED Docker Container

This repository contains a Dockerfile for creating a container with Mellanox OpenFabrics Enterprise Distribution (MLNX_OFED) software package downloaded and prepared for installation.

## Overview

The container is based on Ubuntu 22.04 and includes the MLNX_OFED software package which provides drivers and tools for Mellanox networking products. The current version used is 24.10-2.1.8.0.

## Purpose

This container can be used for:

- Testing MLNX_OFED packages
- Development environments requiring Mellanox networking tools
- Creating a base image for applications that depend on Mellanox networking capabilities

## Prerequisites

- Docker installed on your system
- Internet connectivity to download the MLNX_OFED package
- Root or sudo privileges (for installation if needed)

## Building the Image

```bash
# Clone this repository
git clone https://github.com/scitix/ofed_docker.git
cd ofed-container

# Build the image
docker build -t ofed:24.10-2.1.8.0 .
```

## Running the Container

```bash
# Run the container interactively
docker run -it --privileged ofed:24.10-2.1.8.0
```

Note: The --privileged flag is necessary if you plan to install the MLNX_OFED drivers inside the container.

## Configuration

The Dockerfile uses the following environment variables that can be modified:

- MLNX_OFED_VERSION: The version of MLNX_OFED (default: "24.10-2.1.8.0")
- MLNX_OFED_OS: The target OS for the package (default: "ubuntu22.04-x86_64")

## Installing MLNX_OFED

The Dockerfile downloads and extracts the MLNX_OFED package but doesn't install it by default. To install it, you can:

1. Uncomment the installation line in the Dockerfile:

```dockerfile
RUN ./mlnxofedinstall --user-space-only --without-fw-update --force
```

2. Or manually install after entering the container:

```bash
# Inside the container
cd /tmp/MLNX_OFED_LINUX-24.10-2.1.8.0-ubuntu22.04-x86_64
./mlnxofedinstall --user-space-only --without-fw-update --force
```

## Customization

To use a different version of MLNX_OFED, modify the environment variables in the Dockerfile:

```dockerfile
ENV MLNX_OFED_VERSION="your-version-here"
ENV MLNX_OFED_OS="your-os-here"
```

## Additional Information

- The container has the following tools installed: wget, tar, perl, make, gcc, and linux-headers-generic
- The MLNX_OFED package is downloaded from the official Mellanox repository
- After extraction, the tarball is removed to save space

## Support

For issues with the container, please open an issue in this repository.
For issues with MLNX_OFED itself, please contact Mellanox/NVIDIA support.
