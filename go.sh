#!/bin/bash

init() {
	docker-compose up &
}

doctor() {
	_health account-service
	_health registration-service
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
elif ([ $1 == "init" 		] \
	||  [ $1 == "doctor"  ]); then
	$1
else
	echo "Usage: go.sh [init|doctor] "
fi