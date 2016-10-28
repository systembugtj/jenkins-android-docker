FROM jenkins
USER root

# Add 32bit Lib
RUN apt-get update \
      && apt-get install -y apt-utils
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y lib32stdc++6 lib32z1

# Add Android SDK
RUN wget --progress=dot:giga http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk_r24.4.1-linux.tgz /opt/
RUN cd /opt && tar xzvf ./android-sdk_r24.4.1-linux.tgz
ENV ANDROID_HOME /opt/android-sdk-linux/
ENV PATH $ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
RUN echo $PATH
RUN echo "y" | android update sdk -u --filter tools,platform-tools,android-23,build-tools-23.0.3
RUN chmod -R 755 $ANDROID_HOME

mkdir "$ANDROID_HOME/licenses" || true
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"
