FROM ubuntu

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y nasm
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y qemu-system-i386

VOLUME /root/env
WORKDIR /root/env

CMD ["make"]