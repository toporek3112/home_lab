#################################################################################################
# This docker image is used for debuging and testing feel free to install additional tools.     #
#################################################################################################
# docker build -t debug-tools .                                                                 #
# docker run -it --rm --network custom_bridge debug-tools                                       #
#################################################################################################

# Use OpenJDK 11 JDK base image
FROM openjdk:11-jdk

# Install essential tools
RUN apt-get update && apt-get install -y \
    net-tools \
    procps \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download jmxterm
RUN curl -L -o /root/jmxterm-1.0.2-uber.jar https://github.com/jiaqi/jmxterm/releases/download/v1.0.2/jmxterm-1.0.2-uber.jar

# Set the working directory
WORKDIR /root

# By default, just run a shell. Users can execute Java tools or other commands as needed.
CMD ["/bin/bash"]
