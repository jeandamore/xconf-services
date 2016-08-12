#!/bin/bash

declare -a services=(			\
	'registration-service'  \
	# 'account-service' 			\
	# 'email-service' 				\
	# 'rss-service' 				\
	)

init() {
	clean
	spec
	build
	up
	sleep 5
	doctor
	pact
}

build() {
	for service in "${services[@]}"
	do
		_build $service
	done
}

clean() {
	docker-compose kill
	docker rm -f `docker ps --no-trunc -aq`
}

dive() {
	docker exec -it $1 bash
}

doctor() {
	for service in "${services[@]}"
	do
		_health $service
	done
}

log() {
	for service in "${services[@]}"
	do
		_log $service
	done
}

env() {
	echo XENVIRONMENT=$XENVIRONMENT
	echo RACK_ENV=$RACK_ENV
	echo RACK_PORT=$RACK_PORT
}

spec() {
	for service in "${services[@]}"
	do
		_spec $service
	done
}

scale() {
	docker-compose scale $1=$2
}

pact() {
	for service in "${services[@]}"
	do
		_pact $service
	done
}

up() {
	docker-compose up &
}

_build() {
	echo "Will build $1" 
	pushd $1 >> /dev/null
	./go.sh build
	popd >> /dev/null 
	echo "" 
}

_health() {
	echo "Will ping $1" 
	pushd $1 >> /dev/null
	./go.sh health
	popd >> /dev/null 
	echo "" 
}

_spec() {
	echo "Will spec $1" 
	pushd $1 >> /dev/null
	bundle install
	./go.sh spec
	popd >> /dev/null 
	echo "" 
}

_pact() {
	echo "Will pact $1" 
	pushd $1 >> /dev/null
	bundle install
	./go.sh pact
	popd >> /dev/null 
	echo "" 
}

_log() {
	echo "Will get container log for $1" 
	docker logs -f $1 &
	echo "" 
}


if [ $# -eq 0 ]; then
	init
elif ([ $1 == "clean" 	] \
	||	[ $1 == "env" 		] \
	||	[ $1 == "dive" 		] \
	||	[ $1 == "doctor" 	] \
	||	[ $1 == "init" 		] \
	||	[ $1 == "log" 		] \
	||	[ $1 == "pact" 		] \
	||	[ $1 == "spec" 		] \
	||	[ $1 == "scale" 	] \
	||  [ $1 == "up"  		]); then
	$1 $2 $3
else
	echo "Usage: go.sh [build|clean|dive|doctor|init|log|spec|scale|pact|up] "
fi