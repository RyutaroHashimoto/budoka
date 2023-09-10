FROM python:3.10.0
ENV PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get upgrade -y \
    # Rのインストール
    && apt-get install -y r-base \
    # imageのサイズを小さくするためにキャッシュ削除
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # pipのアップデート
    && pip install --upgrade pip

# Poetryのインストール
RUN pip install poetry

# # pyproject.tomlとpoetry.lockをコピー
COPY pyproject.toml poetry.lock ./

# # 依存関係のインストール
RUN poetry config virtualenvs.create false \
    && poetry install

RUN R -e "install.packages('IRkernel', repos='http://cran.us.r-project.org')"
RUN R -e "IRkernel::installspec(user = FALSE)"

WORKDIR ./root/code



