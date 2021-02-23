# IPFS Docker Image

docker image for ipfs with better defaults

# User

[onichandame](https://onichandame.com)

# Why not official image

The official image comes with minimal customization so most of the settings are default. What's more cumbersome is that the configuration file resides in the data directory and that the data directory should be mounted from the host system. As a result, the configuration is overwritten everytime the container is up.

Moreover, the configurations can only be changed after `ipfs init` and before `ipfs daemon`. The official image does not offer an easy way to do that.

# Usage

`docker run onichandame/ipfs`

Command line arguments of `ipfs daemon` can be specified in env variable `DAEMON_ARGS`

# Configuration

There are 2 ways to configure the IPFS daemon:

1. mount the configuration file
2. mount some scripts

## Mount The Configuration File

Under the root data directory, there are 2 subdirectories for data storage and 1 file for configuration. The official README of go-ipfs recommends to mount the root data directory from host. This setup will overwrite the pre-set configuration on container creation.

My recommendation would be to mount the 2 subdirectories but the root directory to prevent the configuration file from being overwritten.

- root: `/root/.ipfs`
- data subdirectories: `/root/.ipfs/datastore` and `/root/.ipfs/blocks`
- configuration: `/root/.ipfs/config`

## Mount The Scripts

The scripts in `/etc/ipfs` are run after `ipfs init` and `ipfs daemon`. The scripts are run in series but the order of execution is not guaranteed.

The example scripts are [here](./ipfs).
