FROM ubuntu:trusty

RUN apt-get update && apt-get -qq install -y --no-install-recommends \
    build-essential \
    curl \
    libgeos-dev \
    libjpeg-dev \
    libpq-dev \
    python-dev \
    python-pip \
    python-setuptools \
    unzip \
    wget

WORKDIR /usr/src
COPY . .

RUN pip install -U -r requirements.txt && pip install gunicorn

EXPOSE 9090
ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:9090", "TileStache:WSGITileServer('tilestache.cfg')"]
