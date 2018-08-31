## simple irods all in one
## docker build -t "dockerirods-aio:2" .


FROM ubuntu:16.04
MAINTAINER massimo.fares@ingv.it

RUN apt-get update

RUN apt-get install -y lsb-core sudo

RUN apt-get install -y wget git 

RUN apt-get install -y apt-transport-https 

RUN apt-get install -y sudo vim

RUN apt-get install -y ca-certificates

###
### postgresql ###
###

RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

RUN apt-get -y update

RUN apt-get -y upgrade

RUN sudo apt-get install -y postgresql postgresql-contrib libpq-dev pgadmin3



###
### irods-server ####
###

RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | sudo apt-key add -

RUN echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/renci-irods.list

RUN sudo apt-get update

RUN sudo apt-get install -y irods-server irods-database-plugin-postgres




EXPOSE 5432 1247 1248 20000-20199
