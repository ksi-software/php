Convenient Docker images for PHP containing libraries, tools and/or extensions not present in the official PHP images
provided by Docker Inc.

The goal is to simplify and speed-up image building on local and especially CI/CD environments.

All image variants are based on their official equivalents.


## Quick reference

#### Maintained by:
KSI Software & Partners

Visit the GitHub [repository](https://github.com/ksi-software/php) for this project

#### Where to get help:
the Docker Community Slack, Server Fault, Unix & Linux, or Stack Overflow

#### Supported tags and respective Dockerfile links
**Current**: `php:8.3-fpm-grpc`
**Planned**: `php:8.2-fpm-grpc`, `php:8.1-fpm-grpc`, `php:8.3-cli-grpc` etc.

#### Where to file issues:
https://github.com/ksi-software/php/issues


## What is GRPC?
gRPC is an open source, high performance Remote Procedure Call (RPC) framework that can run in any environment.
It is typically used to interconnect services within and across multiple datacenters. You can frequently find it used
in microservices.

Read more [here](https://grpc.io/docs/what-is-grpc/introduction/).


## How to use this image

Our images are drop-in replacements for their official Docker counterparts. Simply use these images as base images
in your Dockerfile or Docker Compose specification:

```Dockerfile
FROM ksisoft/php:8.3-fpm-grpc

WORKDIR /var/www/html

COPY . /myapp

RUN /root/.local/bin/protoc --php_out=./myapp ./myapp/helloworld.proto
```

## Image Variants

At the moment, the only variant offered is the GRPC-ready image, which significantly speeds up local builds and
pipelines which build Docker images.

We aim to provide images for all flavors found in the [official repo](https://hub.docker.com/_/php) which make sense
to us - currently this includes all CLI and FPM tags for PHP versions 8.0+.