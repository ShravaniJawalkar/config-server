# Use the official Jenkins LTS image with JDK 21 as the base
FROM jenkins/jenkins:lts-jdk21

# Switch to the root user to install packages
USER root

# Update the package list and install the openssh-client package
# Clean up the apt cache to keep the image size down
RUN apt-get update && \
    apt-get install -y openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the jenkins user
USER jenkins