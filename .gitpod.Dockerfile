FROM openjdk:11-jdk
RUN apt-get update && apt-get install -y wget tar unzip lib32stdc++6 lib32z1
# Install Android SDK
RUN mkdir /opt/android-sdk
RUN wget -qO- "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" | bsdtar -xvf- -C /opt/android-sdk
ENV ANDROID_HOME /opt/android-sdk
ENV PATH "$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "platforms;android-29" "build-tools;29.0.3"
