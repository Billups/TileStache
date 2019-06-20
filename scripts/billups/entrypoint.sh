#!/bin/sh

set -e

confd -onetime -backend ssm --prefix /${ENVIRONMENT} -node https://ssm.us-west-2.amazonaws.com

TILEGEN_REV="$(rclone lsd remote:billups-artifacts/tilegen | tail -n1 | awk '{print $5}')"
TILEGEN_VER="$(rclone ls remote:billups-artifacts/tilegen/$TILEGEN_REV/products | grep ".edge" | tail -n1 | awk '{print $2}')"
rclone copy -vv --stats 5s remote:billups-artifacts/tilegen/$TILEGEN_REV/products/$TILEGEN_VER /usr/src/data/
tar xfv /usr/src/data/$TILEGEN_VER -C /usr/src/data/
exec rm /usr/src/data/$TILEGEN_VER
