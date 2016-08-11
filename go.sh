#!/bin/bash

declare -a services=(			\
	'account-service' 			\
	'registration-service'	\
	)

init() {
	clean
	spec
	up
	sleep 2
	doctor
	pact
}

up() {
	docker-compose up &
}

clean() {
	docker-compose kill
	docker rm `docker ps --no-trunc -aq`
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

pact() {
	for service in "${services[@]}"
	do
		_pact $service
	done
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
	./go.sh spec
	popd >> /dev/null 
	echo "" 
}

_pact() {
	echo "Will pact $1" 
	pushd $1 >> /dev/null
	./go.sh pact
	popd >> /dev/null 
	echo "" 
}


if [ $# -eq 0 ]; then
	init
elif ([ $1 == "clean" 	] \
	||	[ $1 == "env" 		] \
	||	[ $1 == "init" 		] \
	||	[ $1 == "dive" 		] \
	||	[ $1 == "doctor" 	] \
	||	[ $1 == "pact" 		] \
	||	[ $1 == "spec" 		] \
	||  [ $1 == "up"  		]); then
	$1 $2
else
	echo "Usage: go.sh [clean|init|dive|doctor|spec|pact|up] "
fi