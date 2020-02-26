#!/bin/bash
set -xe
docker run -it --rm -v $PWD:/data android_container:dodroid bash -c "chmod +x ./data/build_dodroid.sh && sh ./data/build_dodroid.sh"