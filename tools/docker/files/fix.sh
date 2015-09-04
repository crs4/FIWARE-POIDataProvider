#!/bin/bash

/etc/init.d/postgresql stop
/etc/init.d/apache2 stop
/etc/init.d/mongodb stop


cd /tmp
LANG=en_US.utf8
locale-gen ${LANG}
update-locale LANG=${LANG}
pg_dropcluster --stop 9.4 main
pg_createcluster --locale en_US.utf8 --start 9.4  main

cp /root/apache2.conf /etc/apache2/apache2.conf

/etc/init.d/postgresql start
cp /root/pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf
/etc/init.d/postgresql restart # unclear HACK

/etc/init.d/mongodb start

sudo -u postgres createuser gisuser
sudo -u postgres createdb --encoding=UTF8 --owner=gisuser poidatabase

sudo -u postgres psql -d poidatabase -f /usr/share/postgresql/9.4/contrib/postgis-2.1/postgis.sql
sudo -u postgres psql -d poidatabase -f /usr/share/postgresql/9.4/contrib/postgis-2.1/spatial_ref_sys.sql
sudo -u postgres psql -d poidatabase -f /usr/share/postgresql/9.4/contrib/postgis-2.1/postgis_comments.sql
sudo -u postgres psql -d poidatabase -c "GRANT SELECT ON spatial_ref_sys TO PUBLIC;"
sudo -u postgres psql -d poidatabase -c "GRANT ALL ON geometry_columns TO gisuser;"
sudo -u postgres psql -d poidatabase -c 'create extension "uuid-ossp";'

cd 
git clone https://github.com/Chiru/FIWARE-POIDataProvider.git
cd FIWARE-POIDataProvider/install_scripts
bash -x ./create_tables.sh
cd
cp -r FIWARE-POIDataProvider/php /var/www/html/poi_dp
wget http://getcomposer.org/composer.phar
php composer.phar require justinrainbow/json-schema:1.4.3
cp -r vendor /var/www/html/poi_dp/

/etc/init.d/apache2 start


