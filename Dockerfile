FROM ubuntu:18.04

LABEL maintainer "Max Golokhov"

ARG VERSION_SDK_TOOLS="4333796"
# mirror versions from dodroid project for now
ARG ANDROID_API_LEVEL=28
ARG ANDROID_BUILD_TOOLS_LEVEL=29.0.2

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH "$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

RUN apt-get -qqy update \
    && apt-get install -qqy --no-install-recommends \
    openjdk-8-jdk \
    git \
    unzip \
    # TODO: do we really need those utils? when do we need them?
    # libglu1 \
    # libpulse-dev \
    # libasound2 \
    # libc6  \
    # libstdc++6 \
    # libx11-6 \
    # libx11-xcb1 \
    # libxcb1 \
    # libxcomposite1 \
    # libxcursor1 \
    # libxi6  \
    # libxtst6 \
    # libnss3 \
    wget \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget -q  "https://dl.google.com/android/repository/sdk-tools-linux-${VERSION_SDK_TOOLS}.zip" -O android_tools.zip && \
    unzip android_tools.zip && \
    rm android_tools.zip

RUN mkdir -p /root/.android \
    && touch /root/.android/repositories.cfg \
    && sdkmanager --update
# TODO: how to manage versioning? 
RUN yes Y | sdkmanager --install \
    'platform-tools' \
    "platforms;android-${ANDROID_API_LEVEL}" \
    "build-tools;${ANDROID_BUILD_TOOLS_LEVEL}" \
    'extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2' \
    'extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2' \
    'extras;google;m2repository' \
    'extras;android;m2repository' \
    'extras;google;google_play_services' \
    && yes Y | sdkmanager --licenses

