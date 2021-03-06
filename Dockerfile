FROM ubuntu:trusty

# Install essential dependencies
RUN apt-get update && apt-get -qq install -y --no-install-recommends \
    build-essential \
    libgeos-dev \
    libjpeg-dev \
    libpq-dev \
    libsqlite3-dev \
    nginx \
    python-dev \
    python-pip \
    python-setuptools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install TileStache dependencies
WORKDIR /usr/src
COPY . .
RUN pip install -r requirements.txt

# Configure nginx and Gunicorn
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
RUN mkdir /var/gunicorn && chown -R www-data:www-data /var/gunicorn

# Run the server process
EXPOSE 9090
ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:9090", "TileStache:WSGITileServer('tilestache.cfg')"]
