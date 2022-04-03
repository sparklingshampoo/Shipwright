

FROM debian:11 as build

ENV LANG C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        binutils:i386 \
        gcc-10:i386 \
        g++-10:i386 \
        python3 \
        python \
        make \
        cmake \
        git \
        lld \
        libsdl2-dev:i386 \
        zlib1g-dev:i386 \
        libbz2-dev:i386 \
        libpng-dev:i386 \
        libgles2-mesa-dev && \
    ln -s /usr/bin/gcc-10 /usr/bin/gcc && \
    ln -s /usr/bin/gcc-10 /usr/bin/cc && \
    ln -s /usr/bin/g++-10 /usr/bin/g++ && \
    ln -s /usr/bin/g++-10 /usr/bin/c++

RUN git clone https://github.com/nigels-com/glew.git && \
    make -C /glew extensions -j$(nproc) && \
    make -C /glew install ARCH64=false

RUN mkdir /soh
WORKDIR /soh

