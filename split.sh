#!/bin/bash

# m1.medium instance on EC2
# create 50GB volume and attach (/dev/sdf becomes /dev/vxdf)
sudo mkfs.xfs /dev/xvdf
sudo mkdir /data
sudo chown ubuntu /data

wget -e 'robots=off' --accept 'xml.gz' --level=1 -m http://europepmc.org/ftp/oa/

mkdir /data/files
find 'ukpmc.ac.uk/ftp/oa' -name '*.xml.gz' -print0 | xargs -0 zcat | awk -F, '$1 ~ /<!DOCTYPE/ { close("/data/files/article-"n".xml"); n++ }n{ f="/data/files/article-"n".xml"; print >f }'
