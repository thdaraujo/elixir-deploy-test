# Refuel

**TODO: Add description**

Project uses [distillery](https://github.com/bitwalker/distillery) to generate releases,
and docker to build the release. That way, the build server OS will always match
the production server.

## How to build

Add permission:
`$ sudo chmod +x build.sh`

Then run:
`$ ./build.sh`

## How to run production container on docker

Add permission:
`$ sudo chmod +x run.sh`

Then run:
`$ ./run.sh`

Then open browser on [localhost:4000](localhost:4000).

## How to stop

Add permission:
`$ sudo chmod +x stop.sh `

Then run:
`$ ./stop.sh `


## How to connect to remote_console

`$ docker exec -it refuel-run /opt/app/bin/refuel remote_console`

## How to deploy (manually)

Add permission:
`$ sudo chmod +x deploy.sh`

Then run:
`$ ./deploy.sh`

Project will be deployed automatically by a CI.
