FROM ubuntu:focal

ARG VERSION="1432"
LABEL maintainer="github.com/kchhan"

WORKDIR /opt

COPY conf /opt/conf

ADD "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip" /opt

RUN \ 
  echo "******* pre-install *******" && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y unzip screen

RUN \
  echo "******* terraria *******" && \
  unzip "terraria-server-${VERSION}.zip" && \
  mv "${VERSION}" "terraria" && \
  chmod +x "terraria/Linux/TerrariaServer.bin.x86_64"  
 
EXPOSE 7777

CMD ["terraria/Linux/TerrariaServer.bin.x86_64", "-config", "/conf/serverconfig.txt"]
