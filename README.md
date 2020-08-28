# docker-ipfs

docker image for ipfs with better defaults

# User

[onichandame](https://onichandame.com)

# Why not official image

The official image comes with minimal customization so most of the settings are default. What's more cumbersome is that the configuration file resides in the data directory. The data directory should be mounted from the host system. As a result, the configuration is overwritten everytime the container is up. Currently there is no easy way to set configurations at building stage. One has to run the commands in the [Dockerfile](./Dockerfile) manually after the container is up.

Some CLI flags are set for my own convenience:

1. `--enable-pubsub-experiment` enables pubsub
