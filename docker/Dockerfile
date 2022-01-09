# Choose version
FROM python:3.8.5

ENV PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get upgrade -y \
    # delete cash to reduce size of image
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # update pip
    && pip install --upgrade pip

COPY ./docker/requirements_base.txt /

RUN pip install --no-cache-dir -r requirements_base.txt

COPY requirements.txt /

RUN pip install --no-cache-dir --ignore-installed -r requirements.txt

# For tensorflow in M1 Mac
# RUN pip install --no-cache-dir --ignore-installed tensorflow -f https://tf.kmtea.eu/whl/stable.html

WORKDIR ./root/code
