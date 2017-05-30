FROM debian:stretch-slim
RUN apt-get update && apt-get -y upgrade && \
  apt-get -y install gcc libgmp-dev libdb-dev make file ncurses-dev autoconf
ADD https://downloads.sourceforge.net/project/open-cobol/gnu-cobol/2.0/gnu-cobol-2.0_rc-2.tar.gz /
RUN tar zfxv gnu-cobol-2.0_rc-2.tar.gz && cd /gnu-cobol-2.0 && \
 ./configure && make && make check && make install
