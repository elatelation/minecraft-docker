# with regards to marc tönsing https://github.com/mtoensing/Docker-Minecraft-PaperMC-Server
ARG jvm=hotspot
ARG java=14

FROM adoptopenjdk:${java}-jre-${jvm}

ARG jvm=hotspot
ARG java=14

COPY paperspigot.jar /paperspigot.jar

ARG startscript=start-${jvm}.sh
COPY $startscript /start.sh
RUN chmod ugo+x /start.sh

RUN groupadd -r minecraft && useradd --no-log-init -rm -g minecraft minecraft

WORKDIR /data

RUN chown -R minecraft:minecraft /data

VOLUME ["/data"]

USER minecraft

# Expose minecraft port
EXPOSE 25565/tcp
EXPOSE 25565/udp

ENV MEMORY_SIZE 2048
ENV EULA false

CMD /start.sh
