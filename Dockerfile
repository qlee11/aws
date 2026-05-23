FROM ubuntu:24.04

RUN apt-get update -y

RUN apt-get install pv -y

WORKDIR /app

ADD TavernQuest/ /app

RUN ls -lah

RUN chmod 100 TavernQuest.sh

ENTRYPOINT ["/app/TavernQuest.sh"]