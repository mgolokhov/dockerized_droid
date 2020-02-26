#!/bin/bash
set -xe
git clone https://github.com/mgolokhov/dodroid.git
cd dodroid
# TODO: do need to check both release and debug? if it's just one, which is better?
./gradlew assemble check