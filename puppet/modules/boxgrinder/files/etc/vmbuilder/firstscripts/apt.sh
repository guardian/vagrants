#!/bin/sh -e

mkdir -p /etc/apt/apt.conf.d

echo 'Acquire::http::Timeout "300";' > /apt/apt/apt.conf.d/30timeout
echo 'Acquire::http::Retries "3";' > /apt/apt/apt.conf.d/31retries

apt-get update
