#!/bin/sh

/usr/sbin/nginx -c /etc/nginx/nginx.conf & \
exec gunicorn -c gunicorn.py "TileStache:WSGITileServer('tilestache.cfg')"
