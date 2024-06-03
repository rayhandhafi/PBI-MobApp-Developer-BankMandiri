FROM gitpod/workspace-full

# Install Android SDK
RUN mkdir -p ${ANDROID_HOME} .android && \
    cd ${ANDROID_HOME} && \
    wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O tools.zip && \
    unzip tools.zip && \
    rm tools.zip && \
    yes | sdkmanager --licenses && \
    sdkmanager --update

# Install essential build tools
RUN sdkmanager "build-tools;29.0.2" "platform-tools" "platforms;android-29"

# Set environment variables
ENV ANDROID_HOME=/home/gitpod/android-sdk-linux
ENV PATH=$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

# Accept licenses
RUN mkdir -p "$ANDROID_HOME/licenses" && \
    echo -e "\n24333f8a63b6825ea9c5514f83c2829b004d1fee\n" > "$ANDROID_HOME/licenses/android-sdk-license" && \
    echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd\n" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

# Install Gradle
RUN sdkmanager "cmdline-tools;latest" && \
    wget https://services.gradle.org/distributions/gradle-6.6.1-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-6.6.1-bin.zip && \
    ln -s /opt/gradle/gradle-6.6.1/bin/gradle /usr/bin/gradle

ENV PATH=/opt/gradle/gradle-6.6.1/bin:$PATH
