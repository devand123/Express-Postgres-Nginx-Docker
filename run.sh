#!/bin/bash

build(){
  docker-compose build
}

run(){
  docker-compose up
}

check_dependencies_and_run(){
  command -v docker >/dev/null 2>&1 || {
    echo >&2 "You need to install Docker first"; return 0;
  }
  command -v docker-compose >/dev/null 2>&1 || {
    echo >&2 "Can not find docker-compose command"; return 0;
  }
  run &
  open http://localhost
}

check_dependencies_build_and_run(){
  command -v docker >/dev/null 2>&1 || {
    echo >&2 "You need to install Docker first"; return 0;
  }
  command -v docker-compose >/dev/null 2>&1 || {
    echo >&2 "Can not find docker-compose command"; return 0;
  }
  build
  run &
  open http://localhost
}

generate_api_doc(){
  cd app/
  apidoc -i ./routes/ -o ../apidoc
  cd ..
}

run_dev(){
  docker-compose up db &
  cd app
  bash start.sh && cd ..
  open http://localhost
}

if [ $1 == "build" ]; then
  check_dependencies_build_and_run
elif [ $1 == "run" ]; then
  check_dependencies_and_run
elif [ $1 == "apidoc" ]; then
  generate_api_doc
elif [ $1 == "dev" ]; then
  run_dev
else
  echo "Unknown command";
fi