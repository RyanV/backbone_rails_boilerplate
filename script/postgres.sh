#!/bin/bash

sudo sysctl -w kern.sysv.shmall=65536
sudo sysctl -w kern.sysv.shmmax=16777216
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
