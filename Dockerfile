# Published on Docker Hub with above user alexellisio.

# If you want to rebuild your own copy, follow below instructions
# Build this on each type of machine so you have the correct CPU extensions.
FROM ubuntu:latest

WORKDIR /root/
RUN apt-get update -qy && \
    apt-get install -qy cmake build-essential libboost-all-dev git ca-certificates \
    --no-install-recommends
RUN git clone -b Linux https://github.com/nicehash/nheqminer.git
RUN cd nheqminer/cpu_xenoncat/Linux/asm/ && sh assemble.sh && cd ../../../Linux_cmake/nheqminer_cpu && cmake . && make

ENTRYPOINT ["./nheqminer/Linux_cmake/nheqminer_cpu/nheqminer_cpu"]
# -u contains destination address.
CMD ["-l", "eu1-zcash.flypool.org:3333", "-u", "t1cELmy7HqZR4ioPEnGud897Z8F52kXhVks.Docker", "-t", "4"]
#ENTRYPOINT ["/bin/bash"]
