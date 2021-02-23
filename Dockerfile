FROM ipfs/go-ipfs:latest AS ipfs

# install go-ipfs
FROM busybox:1.31.1-glibc
COPY --from=ipfs /usr/local/bin/ipfs /usr/bin/ipfs
COPY --from=ipfs /lib/libdl.so.2 /lib/
COPY --from=ipfs /usr/lib/* /usr/lib/

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
