FROM ipfs/go-ipfs:latest AS ipfs

# install go-ipfs
FROM centos:8
RUN dnf update -y
RUN dnf install openssh-clients openssh-server -y
RUN echo 'root:123456' | chpasswd
RUN ssh-keygen -A
RUN rm -f /run/nologin

COPY --from=ipfs /usr/local/bin/ipfs /usr/bin/ipfs
COPY --from=ipfs /lib/libdl.so.2 /lib/
COPY --from=ipfs /usr/lib/* /usr/lib/

# configure node to accept REST API calls
CMD ipfs init \
    ; ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["GET", "POST"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location"]' \
    && ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]' \
    && ipfs config --json Addresses.API '"/ip4/0.0.0.0/tcp/5001"' \
    && ipfs config --json Addresses.Gateway '"/ip4/0.0.0.0/tcp/8080"' \
    && ipfs config --json Experimental.Libp2pStreamMounting true \
    && ipfs config --json Swarm.EnableAutoRelay 'true' \
    && ipfs daemon --enable-pubsub-experiment
