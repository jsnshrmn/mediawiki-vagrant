#!/usr/bin/env bash

working_dir=$(pwd)
cd /vagrant/mediawiki
sudo -i bash -c "mysql < /vagrant/twl.sql;"
mwscript maintenance/sql.php --wikidb centralauth extensions/CentralAuth/central-auth.sql;
mwscript maintenance/sql.php --wikidb centralauth extensions/GlobalPreferences/sql/mysql/tables-generated.sql;
mwscript extensions/CentralAuth/maintenance/migratePass0.php
mwscript extensions/CentralAuth/maintenance/migratePass1.php
mwscript maintenance/update.php --quick;
cd $working_dir
