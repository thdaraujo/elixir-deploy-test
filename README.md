# Refuel

**TODO: Add description**

Project uses [distillery](https://github.com/bitwalker/distillery) to generate releases,
and docker to build the release. That way, the build server OS will always match
the production server.

## How to build

`$ docker build -t refuel:latest . `

## How to run

`$ docker run --name refuel -it -p 4000:4000 refuel:latest`

Then open browser on [localhost:4000](localhost:4000).

## How to connect to remote_console

`$ docker exec -it refuel /opt/app/bin/refuel remote_console`
