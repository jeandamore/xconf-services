#!/bin/bash

export RACK_ENV=production
export RACK_PORT=3000

export SERVICE_NAME=$(basename "$PWD")
echo "Will execute target $1 for $SERVICE_NAME"

build() {
	docker build -t $SERVICE_NAME .
}

run() {
	docker run -it --name $SERVICE_NAME --link account-service:account-service -d -p $RACK_PORT:$RACK_PORT --env RACK_PORT=$RACK_PORT $SERVICE_NAME
}

clean() {
	docker rm -f $SERVICE_NAME
}

health() {
	curl -f http://127.0.0.1:$RACK_PORT
}

preflight() {	
	rvm use 2.3.1
	rvm gemset create $SERVICE_NAME
	rvm gemset use $SERVICE_NAME
	bundle install
	bundle exec rake
	build
	run
	sleep 1
	health
	clean
}

start() {
	bundle exec rake spec server:run 
}

test() {	
	bundle exec rake spec
	bundle exec rake pact
}

if [ $# -eq 0 ]; then
	preflight
elif ([ $1 == "build" 		] \
	||  [ $1 == "run"  			] \
	||  [ $1 == "preflight" ] \
	||  [ $1 == "start" 		] \
	||  [ $1 == "test" 			]); then
	$1
else
	echo "Usage: go.sh [options] (type 'go.sh help' for more details)"
fi