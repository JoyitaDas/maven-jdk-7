FROM java:openjdk-7-jdk

ENV MAVEN_VERSION 3.3.3

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV PATH="/usr/lib/jvm/java-8-openjdk-amd64/bin:${PATH}"

# Adding Debian stretch repository to the source list to be able to install openjdk8
RUN echo "deb http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list

# Installing JDK 8
RUN set -x &&  apt-get update \
    && apt-get install -y openjdk-8-jre-headless \
    && apt-get install -y openjdk-8-jdk

CMD ["mvn"]
