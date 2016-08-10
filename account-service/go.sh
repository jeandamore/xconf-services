#!/bin/bash

export RACK_ENV=production

export SERVICE_NAME=$(basename "$PWD")
echo "Will execute target $1 for $SERVICE_NAME"

build() {
	docker build -t $SERVICE_NAME .
}

run() {
	docker run -it --name $SERVICE_NAME -d -p 3001:4001 --env RACK_PORT=4001 $SERVICE_NAME
}

preflight() {	
	rvm use 2.3.1
	rvm gemset create $SERVICE_NAME
	rvm gemset use $SERVICE_NAME
	gem install bundler
	bundle install
	bundle exec rake spec
}

start() {
	set RACK_PORT=3000
	bundle exec rake spec server:run 
}

test() {	
	bundle exec rake spec
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