include docker/.env
export $(shell sed 's/=.*//' docker/.env)

.PHONY: all build_ui build_post build_comment build_prometheus build_alertmanager push_ui push_post push_comment push_prometheus push_alertmanager

#Build
build: build_ui build_post build_comment build_prometheus build_alertmanager

build_all: build

build_ui:
	    cd src/ui && bash docker_build.sh
build_post:
	    cd src/post-py && bash docker_build.sh
build_comment:
	    cd src/comment && bash docker_build.sh
build_prometheus:
	    cd monitoring/prometheus docker build -t $(USER_NAME)/prometheus .
build_alertmanager:
	    cd monitoring/alertmanager docker build -t $(USER_NAME)/alertmanager .

#Push images
push: push_ui push_post push_comment push_prometheus push_alertmanager

push_all: push

push_ui:
	docker push $(USER_NAME)/ui
push_post:
	docker push $(USER_NAME)/post
push_comment:
	docker push $(USER_NAME)/comment
push_prometheus:
	docker push $(USER_NAME)/prometheus
push_alertmanager:
	docker push $(USER_NAME)/alertmanager

