FROM python:3.8.5
MAINTAINER Ryutaro Hashimoto & Yuzi Hayashi
ENV PYTHONUNBUFFERED=1

# https://github.com/amagaeru1113/templates/tree/main/analysis_and_experiments
RUN echo "alias klab='kedro jupyter lab --ip=0.0.0.0 --allow-root'" >> ~/.bash_profile  && \
    echo "alias knote='jupyter notebook --ip='0.0.0.0' --allow-root'" >> ~/.bash_profile && \
    echo "alias mfui='mlflow ui --host 0.0.0.0'" >> ~/.bash_profile && \
    echo "alias kviz='kedro viz --host 0.0.0.0'" >> ~/.bash_profile

RUN apt-get update \
    && apt-get upgrade -y \
    # imageのサイズを小さくするためにキャッシュ削除
#    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # pipのアップデート
    && pip install --upgrade pip

COPY requirements_base.txt /
COPY requirements.txt /

RUN pip install --ignore-installed -r requirements_base.txt
# RUN pip install --no-cache-dir --ignore-installed -r requirements_base.txt

RUN pip install --ignore-installed -r requirements.txt

WORKDIR ./code





