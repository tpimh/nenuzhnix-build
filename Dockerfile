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
	groff \
	libarchive-tools \
	libexecinfo \
	libstdc++ \
	libtool \
	make \
	ninja \
	patch \
	pkgconf \
	tar \
	util-linux \
	wget \
	xz

RUN curl --progress-bar -O https://golovin.in/ngtc-x86_64-11.0.0.tar.gz && \
	tar xvf ngtc-x86_64-11.0.0.tar.gz && rm ngtc-x86_64-11.0.0.tar.gz

COPY ./root /
