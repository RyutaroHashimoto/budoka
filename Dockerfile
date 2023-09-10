FROM python:3.10.0
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

# Poetryのインストール
RUN pip install poetry

# # pyproject.tomlとpoetry.lockをコピー
# COPY pyproject.toml poetry.lock ./
COPY pyproject.toml ./

# # 依存関係のインストール
RUN poetry config virtualenvs.create false \
    && poetry install

RUN apt-get update && \
    apt-get install -y r-base

RUN R -e "install.packages('IRkernel', repos='http://cran.us.r-project.org')" \
    && R -e "IRkernel::installspec(user = FALSE)"

WORKDIR ./code



