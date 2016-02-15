FROM debian:jessie
MAINTAINER IronicBadger <ironicbadger@linuxserver.io>

# Builds netatalk
# http://netatalk.sourceforge.net/wiki/index.php/Install_Netatalk_3.1.8_on_Debian_8_Jessie
RUN apt-get update
RUN apt-get install -y \
      build-essential \
      libevent-dev \
      libssl-dev \
      libgcrypt11-dev \
      libkrb5-dev \
      libpam0g-dev \
      libwrap0-dev \
      libdb-dev \
      libtdb-dev \
      libmysqlclient-dev \
      avahi-daemon \
      libavahi-client-dev \
      libacl1-dev \
      libldap2-dev \
      libcrack2-dev \
      systemtap-sdt-dev \
      libdbus-1-dev \
      libdbus-glib-1-dev \
      libglib2.0-dev \
      tracker \
      libtracker-sparql-1.0-dev \
      libtracker-miner-1.0-dev \
      wget \
      checkinstall
RUN mkdir -p /app/build && \
    mkdir /artifact
ADD build-source-runtime /app/
WORKDIR /app
RUN chmod +x build-source-runtime
VOLUME ["/artifact"]
CMD ["/app/build-source-runtime"]
