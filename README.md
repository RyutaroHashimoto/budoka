# budoka

## Prerequisite
- Docker
- Docker-compose
- make
## How to use

1. build

    `make build`

2. launch app

    `make <name>`

    - shell
    - jupyternotebook
    - jupyterlab
    - mlflow
    - both (jupyterlab & mlflow)

3. stop container

    `make stop`

4. restart container

    `make restart`

5. clean

    `make clean`

## Kedro Jupyter Notebook or Lab in shell

- kedro jupyter lab --ip=0.0.0.0 --allow-root
- kedro jupyter notebook --ip=0.0.0.0 --allow-root
- <http://0.0.0.0:8888/>

## MLFlow UI

- mlflow ui --host 0.0.0.0
- <http://0.0.0.0:5001/>
- <localhost:5001>
