#!/bin/bash

declare -a services=(			\
	'account-service' 			\
	'registration-service'	\
	)

init() {
	clean
	test
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
	for service in "${services[@]}"
	do
		_health $service
	done
}

test() {
	for service in "${services[@]}"
	do
		_test $service
	done
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

_test() {
	echo "Will test $1" 
	pushd $1 >> /dev/null
	./go.sh test
	popd >> /dev/null 
	echo "" 
}


if [ $# -eq 0 ]; then
	init
elif ([ $1 == "clean" 	] \
	||	[ $1 == "init" 		] \
	||	[ $1 == "dive" 		] \
	||	[ $1 == "doctor" 	] \
	||	[ $1 == "test" 		] \
	||  [ $1 == "up"  		]); then
	$1 $2
else
	echo "Usage: go.sh [clean|init|dive|doctor|test|up] "
fi