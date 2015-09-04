#!/bin/bash

scp -P 3000 files/apache2.conf root@localhost:apache2.conf
scp -P 3000 files/pg_hba.conf root@localhost:pg_hba.conf
scp -P 3000 files/fix.sh root@localhost:fix.sh
