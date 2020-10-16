# IPFS Docker Image

docker image for ipfs with better defaults

# User

[onichandame](https://onichandame.com)

# Why not official image

The official image comes with minimal customization so most of the settings are default. What's more cumbersome is that the configuration file resides in the data directory. The data directory should be mounted from the host system. As a result, the configuration is overwritten everytime the container is up. Currently there is no easy way to set configurations at building stage. One has to run the commands in the [Dockerfile](./Dockerfile) manually after the container is up.

Some options are set for my own convenience:

1. pubsub enabled
2. cors allowed

# Recommended Usage

`docker run -d --restart always -p 5001:5001 -v /ipfs/datastore:/root/.ipfs/datastore -v /ipfs/blocks:/root/.ipfs/blocks onichandame/ipfs`

The REST API is exposed to port 5001 to allow the access from [ipfs-http-client](https://www.npmjs.com/package/ipfs-http-client).

Under the root data directory, there are 2 subdirectories for data storage and 1 file for configuration. The official README of go-ipfs recommends to mount the root data directory from host. This setup will overwrite the pre-set configuration on container creation.

My recommendation would be to mount the 2 subdirectories but the root directory to prevent the configuration file from being overwritten.

- root: `/root/.ipfs`
- data subdirectories: `/root/.ipfs/datastore` and `/root/.ipfs/blocks`
- configuration: `/root/.ipfs/config`
