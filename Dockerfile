FROM python:3.8.5

ENV PYTHONUNBUFFERED=1

#RUN echo "alias klab='kedro jupyter lab --ip=0.0.0.0 --allow-root'" >> /root/.bashrc
#RUN echo "alias mfui='mlflow ui --host 0.0.0.0'" >> /root/.bashrc
#RUN echo "alias kviz='kedro viz --host 0.0.0.0'" >> /root/.bashrc



COPY requirements.txt /

RUN apt-get update \
    && apt-get upgrade -y \
    # imageのサイズを小さくするためにキャッシュ削除
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # pipのアップデート
    && pip install --upgrade pip

RUN pip install -r  requirements.txt

WORKDIR ./code





