FROM alpine:latest

RUN apk add --no-cache -t .builddeps \
	autoconf \
	automake \
	bash \
	bison \
	bzip2 \
	cmake \
	coreutils \
	curl \
	file \
	findutils \
	gettext-dev \
	git \
	gperf \
	libarchive-tools \
	libexecinfo \
	libstdc++ \
	libtool \
	make \
	ninja \
	patch \
	pkgconf \
	tar \
	wget \
	xz

RUN curl --progress-bar -O https://golovin.in/x86_64-pc-linux-musl.tar.gz && \
	tar xvf x86_64-pc-linux-musl.tar.gz && rm x86_64-pc-linux-musl.tar.gz

COPY ./root /
