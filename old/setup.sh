#!/bin/bash
ENV=${2:-app}
SCRIPT=$3
MODE=$4
DOMAIN=$5

function prop {
  grep "${1}" ${ENV}.properties|cut -d'=' -f2
}

function build {
  docker build -f nginx/Dockerfile -t $(prop 'app.name'):$(prop 'app.version') .
  docker images | grep $(prop 'app.name')
}

function create {
  docker \
    create \
    --name $(prop 'app.name') \
    -h app-$(prop 'app.name') \
    -p 80:80 \
    -p 443:443 \
    -v $(prop 'app.data-path'):/var/www \
    $(prop 'app.name'):$(prop 'app.version')
}

function start {
  docker start $(prop 'app.name')
}

function stop {
  docker stop $(prop 'app.name')
}

function remove {
  stop
  docker rm $(prop 'app.name')
}

function logs {
  docker logs -f $(prop 'app.name')
}

function exec {
  docker exec $(prop 'app.name') $SCRIPT $MODE $DOMAIN
}

case "$1" in
  build)
    echo "Building '$(prop 'app.name')' version $(prop 'app.version'): "
    build
  ;;
  create)
    echo "Creating '$(prop 'app.name')' container version $(prop 'app.version'): "
    create
  ;;
  stop)
    echo "Stopping '$(prop 'app.name')' container version $(prop 'app.version'): "
    stop
  ;;
  start)
    echo "Starting '$(prop 'app.name')' container version $(prop 'app.version'): "
    start
  ;;
  remove)
    echo "Removing '$(prop 'app.name')' container version $(prop 'app.version'): "
    remove
  ;;
  logs)
    echo "Showing logs for '$(prop 'app.name')' container version $(prop 'app.version'): "
    logs
  ;;
  exec)
    echo "Executing '$SCRIPT $MODE $DOMAIN' in '$(prop 'app.name')': "
    exec
  ;;
  *)
    echo "Usage: $0 ( build | create | start | stop | remove | logs | exec )"
  ;;
esac
