all: build

build:
	docker build . -t haenerconsulting/quantlib-jupyter

push: build
	docker push
