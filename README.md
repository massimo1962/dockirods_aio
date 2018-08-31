

## build and run irods all-in-one (with icat database)



disclaimer: every name and directory are not mandatory (except for the database) they could be whatever.

### 1)build an image within irods and postrgesql:

docker build -t "dockerirods-aio:1" .


### 2)launch the all-in-one container:

docker run -it --name dockirods_aio  -v /data/data_icat_db:/var/lib/postgsql/data -v /mnt/seedstore_nfs:/var/lib/datairods -v /opt/eudat/myrules:/var/lib/irods/myrules -v /opt/eudat/myVault:/var/lib/irods/Vault -p 1247:1247 -p 1248:1248 -p 5432:5432 -p 20000-20199:20000-20199   dockerirods-aio:1 /bin/bash


there are several volumes (host directory) mounted on container, they are:

Database data-directory:
<host path> : <container path>
/data/data_icat_db:/var/lib/postgsql/data

Repository of Mseed files:
/mnt/seedstore_nfs:/var/lib/datairods

directory of rules:
/opt/eudat/myrules:/var/lib/irods/myrules

Vault directory (the directory used by irods to store files - not for our case but useful)
/opt/eudat/myVault:/var/lib/irods/Vault

in order to make persistent all data inside irods and icat db;
the rules directory is used to update some script , if needed, without touch the container.

 after docker container is started you are into container:

### 3) SETUP ALL:

prep ICAT
---------

inside psql:

from root become postgres user
su - postgres

psql

postgres=# create user irods with password 'xoxoxo';
CREATE ROLE

postgres=# create database "ICAT";
CREATE DATABASE

postgres=# grant all privileges on database "ICAT" to irods;
GRANT
postgres=# 

exit



setup irods
-----------

from root

python /var/lib/irods/scripts/setup_irods.py

reply on interactive installation:

user:irods password:xoxoxo 

-------------------------------------------
"zone_key": "XOXOXO_ZONE_SID"

"negotiation_key": "xxxx_32_byte_key_for_agent__conn",

"server_control_plane_key": "TEMPORARY__32byte_ctrl_plane_key"

"xmsg_port": 1279,

"zone_auth_scheme": "native",

"zone_name": "XXXX",

"zone_port": 1247,

"zone_user": "rods"


### 4)start irods


become irods user
su - irods

cd /var/lib/irods
./irodsctl start

### 5)check irods/postgres/ICAT


(su - irods)

iinit
(pswd)

ils 

that's it  :-)



