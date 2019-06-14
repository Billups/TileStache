#!/bin/sh

set -e

TILEGEN_REV="$(rclone lsd s3:billups-artifacts/tilegen | tail -n1 | awk '{print $5}')"
TILEGEN_VER="$(rclone ls s3:billups-artifacts/tilegen/$TILEGEN_REV/products | grep ".edge" | tail -n1 | awk '{print $2}')"
rclone copy -v --stats 5s s3:billups-artifacts/tilegen/$TILEGEN_REV/products/$TILEGEN_VER .
tar xfv $TILEGEN_VER -C /usr/src/data/
rm $TILEGEN_VER
