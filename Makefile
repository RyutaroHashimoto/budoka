.PHONY: build up shell jupyternotebook jupyterlab stop clean

# Test if the dependencies we need to run this Makefile are installed
DOCKER := $(shell command -v docker)
DOCKER_COMPOSE := $(shell command -v docker-compose)

ifndef DOCKER
    @echo "Docker is not available. Please install docker"
    @exit 1
endif
ifndef DOCKER_COMPOSE
    @echo "docker-compose is not available. Please install docker-compose"
    @exit 1
endif

all: shell

build: .build.docker

.build.docker: ./docker/docker-compose.yml ./docker/Dockerfile
	docker-compose -f ./docker/docker-compose.yml build

up: .up.docker

.up.docker: build
	docker-compose  -f ./docker/docker-compose.yml up -d

shell: up
	@echo "\n     launching the shell in container. type 'exit' to finish \n"
	docker exec -it budoka-container /bin/sh

jupyternotebook: up
	@echo "\n     launching jupyternotebook \n"
	@echo "    To access jupyterlab, access the URL showing later as usual \n"
	docker exec -it budoka-container jupyter notebook --ip='0.0.0.0' --allow-root

jupyterlab: up
	@echo "\n     launching jupyterlab \n"
	@echo "    To access jupyterlab, access the URL showing later as usual \n"
	docker exec -it budoka-container jupyter lab --ip='0.0.0.0' --allow-root --NotebookApp.quit_button=True

mlflow: up
	docker exec -it budoka-container mlflow ui --host 0.0.0.0

both: up
	@echo "\n     launching jupyterlab and mlflow \n"
	@echo "    To access jupyterlab, access the URL showing later as usual"
	@echo "    To access mlflow, access localhost:5001 \n"
	docker exec -it budoka-container bash -c "jupyter lab --ip='0.0.0.0' --allow-root --NotebookApp.quit_button=True & mlflow ui --host 0.0.0.0"

stop:
	docker-compose -f ./docker/docker-compose.yml stop

restart:
	docker-compose -f ./docker/docker-compose.yml stop
	docker-compose  -f ./docker/docker-compose.yml up -d

clean:
	docker-compose -f ./docker/docker-compose.yml down --rmi all --volumes --remove-orphans
	rm -f .build.docker .up.docker
