FROM debian:stretch-slim
RUN apt-get update && \
    apt-get -y upgrade
#
#  Break here to allow for caching of image after upgrade -- it should shorten
#  the lather-rinse-repeat cycle time
#
RUN apt-get -y install gcc libgmp-dev libdb-dev make file ncurses-dev autoconf \
    curl fuse ruby
RUN mkdir /build && cd /build && \
    curl -LO https://downloads.sourceforge.net/project/open-cobol/gnu-cobol/2.0/gnu-cobol-2.0_rc-2.tar.gz && \
    tar zfxv gnu-cobol-2.0_rc-2.tar.gz && \
    cd gnu-cobol-2.0 && \
    ./configure && \
    make && \
    make check && \
    make install
#
#  These are the added dependencies for for File Systems -- they may get broken
#  out to a separate Dockerfile in the future because they (MAY)
RUN cd /build && \
    curl -LO https://github.com/ovh/svfs/releases/download/v0.9.1/svfs_0.9.1_amd64.deb && \
    dpkg --install svfs_0.9.1_amd64.deb
