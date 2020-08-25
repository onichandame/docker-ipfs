# docker-ipfs

docker image for ipfs with better defaults

# User

[onichandame](https://onichandame.com)

# Why not official image

The official image comes with minimal customization so most of the settings are default. One of the default settings is to enable CORS protection, so that only localhost from the machine running the daemon is allowed to use the REST API.

However when the daemon is running in a container, the API requests usually do not come from the container itself. So such protection must be disabled.
