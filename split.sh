#!/bin/bash

# m1.medium instance on EC2
# create 50GB volume and attach (/dev/sdf becomes /dev/vxdf)
sudo mkfs.xfs /dev/xvdf
sudo mkdir /data
sudo mount /dev/xvdf /data
sudo chown ubuntu /data

cd /data

mkdir europepmc
wget -e 'robots=off' --accept '.xml.gz' --recursive --level=1 --timestamping --no-parent --no-directories --continue --directory-prefix=europepmc http://europepmc.org/ftp/oa/

mkdir articles
find 'europepmc' -name '*.xml.gz' -print0 | xargs -0 zcat | awk -F, '$1 ~ /<!DOCTYPE/ { close("articles/article-"n".xml"); n++ }n{ f="articles/article-"n".xml"; print >f }'
