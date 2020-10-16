FROM ipfs/go-ipfs:latest AS ipfs

# install go-ipfs
FROM busybox:1.31.1-glibc
COPY --from=ipfs /usr/local/bin/ipfs /usr/bin/ipfs
COPY --from=ipfs /lib/libdl.so.2 /lib/
COPY --from=ipfs /usr/lib/* /usr/lib/

# configure node to accept REST API calls
RUN ipfs init \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["GET", "POST"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]' \
    && ipfs config --json Addresses.API '"/ip4/0.0.0.0/tcp/5001"' \
    && ipfs config --json Addresses.Gateway '"/ip4/0.0.0.0/tcp/8080"' \
    && ipfs config --json Experimental.Libp2pStreamMounting true \
    && ipfs config --json Swarm.EnableAutoRelay 'true'

# enable pubsub
CMD ["ipfs", "daemon", "--enable-pubsub-experiment"]
