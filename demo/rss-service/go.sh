#!/bin/bash

export XENVIRONMENT=${XENVIRONMENT:-development}
export RACK_PORT=8080
export RACK_ENV=production
export SERVICE_NAME=$(basename "$PWD")

rvm use 2.3.1
rvm gemset create $SERVICE_NAME
rvm gemset use $SERVICE_NAME

build() {
	docker build -t $SERVICE_NAME .
}

proxy() {
	docker run -it --name nginx-proxy -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy 
}

run() {
	docker run -it --name $SERVICE_NAME -d -p $RACK_PORT --env RACK_PORT=$RACK_PORT --env VIRTUAL_HOST=$SERVICE_NAME $SERVICE_NAME
}

clean() {
	docker rm -f nginx-proxy
	docker rm -f $SERVICE_NAME
}

health() {
	curl -f http://$SERVICE_NAME:$RACK_PORT/health
}

test() { 
	echo "Not implemented"
}

spec() { 
	echo "Not implemented"
}

pact() { 
	echo "Not implemented"
}

preflight() {	
	clean
	bundle install
	bundle exec rake
	build
	proxy
	run
	sleep 2
	health
}

start() {
	bundle exec rake server:run 
}

if [ $# -eq 0 ]; then
	preflight
elif ([ $1 == "build" 		] \
	||  [ $1 == "clean"  		] \
	||  [ $1 == "health"  	] \
	||  [ $1 == "pact" 			] \
	||  [ $1 == "preflight" ] \
	||  [ $1 == "proxy"  		] \
	||  [ $1 == "run"  			] \
	||  [ $1 == "start" 		] \
	||  [ $1 == "spec" 			] \
	||  [ $1 == "test" 			]); then
	$1
else
	echo "Usage: go.sh [build|clean|health|pact|preflight|proxy|run|start|spec|test]"
fi