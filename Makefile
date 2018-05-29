include docker/.env

.PHONY: all build_ui build_post build_comment build_prometheus push_ui push_post push_comment push_prometheus

#Build
build: build_ui build_post build_comment build_prometheus

build_all: build

build_ui:
	    cd src/ui && bash docker_build.sh
build_post:
	    cd src/post-py && bash docker_build.sh
build_comment:
	    cd src/comment && bash docker_build.sh
build_prometheus:
	    cd monitoring/prometheus docker build -t $(USER_NAME)/prometheus .

#Push images
push: push_ui push_post push_comment push_prometheus

push_all: push

push_ui:
	docker push $(USER_NAME)/ui
push_post:
	docker push $(USER_NAME)/post
push_comment:
	docker push $(USER_NAME)/comment
push_prometheus:
	docker push $(USER_NAME)/prometheus

