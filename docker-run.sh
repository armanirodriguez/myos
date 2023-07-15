#! /bin/sh

# Checks if there is a docker container called "myos" and runs
# docker build if not foundmake
#if [[ "$(docker images -q myos 2> /dev/null)" == "" ]]; then
  docker build . -t myos --platform linux/amd64
#fi

# Compile
docker run --platform linux/amd64 --rm -it -v $(pwd):/root/env myos

# Run
qemu-system-i386 -drive format=raw,file=os.bin,index=0,if=floppy
