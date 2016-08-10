#!/bin/bash

init() {
	clean
	up
	sleep 2
	doctor
}

up() {
	docker-compose up &
}

clean() {
	docker-compose kill
}

doctor() {
	_health account-service
	_health registration-service
}

dive() {
	docker exec -it $1 bash
}

_health() {
	echo "Will ping $1" 
	pushd $1 >> /dev/null
	./go.sh health
	popd >> /dev/null 
	echo "" 
}


if [ $# -eq 0 ]; then
	init
elif ([ $1 == "clean" 	] \
	||	[ $1 == "init" 		] \
	||	[ $1 == "dive" 		] \
	||	[ $1 == "doctor" 	] \
	||  [ $1 == "up"  		]); then
	$1 $2
else
	echo "Usage: go.sh [clean|init|dive|doctor|up] "
fi