FROM php:8.3-fpm

# Run apt-get in quiet mode and assume yes on prompts
RUN apt-get update -qy

# Install dependencies for php-gd extension
RUN apt-get install -qy libicu-dev libpq-dev libzip-dev zip git cmake

# Install PECL extensions
RUN export MAKEFLAGS="-j $(nproc)" \
     && pecl install grpc protobuf \
     && docker-php-ext-enable grpc protobuf

WORKDIR /grpc

# Download the protoc binary
RUN curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v27.0/protoc-27.0-linux-x86_64.zip

RUN unzip protoc-27.0-linux-x86_64.zip -d /root/.local \
    && rm protoc-27.0-linux-x86_64.zip

# Build the PHP gRPC extension
RUN git clone --depth 1 -b v1.64.0 https://github.com/grpc/grpc .
RUN git submodule update --init && mkdir -p cmake/build

WORKDIR /grpc/cmake/build

RUN cmake ../..
RUN make protoc grpc_php_plugin

# Move the built binaries
RUN mv ./grpc_php_plugin /root/.local/bin/grpc_php_plugin

# Make protoc available in the PATH and executable from anywhere
ENV PATH="$PATH:/root/.local/bin"

RUN echo "export PATH=$PATH" > /etc/environment

# Clean up all the build dependencies
RUN apt remove --purge -y git cmake \
    && apt autoremove -y

RUN rm -rf /grpc

WORKDIR /var/www/html