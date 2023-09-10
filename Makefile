SHELL := /bin/bash

# all: clean install test lint format up down easter

build:
	docker-compose up --build  -d

shell: build
	docker exec -it budoka-container /bin/bash

lab: build
	docker exec -it budoka-container jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.quit_button=True

end:
	docker stop budoka-container
