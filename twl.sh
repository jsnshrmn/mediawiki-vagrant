#!/usr/bin/env bash

# download extensions
cd /vagrant/mediawiki/extensions/
if [ ! -d CentralAuth ]; then
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CentralAuth
fi
if [ ! -d Echo ]; then
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Echo
fi
if [ ! -d GlobalPreferences ]; then
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/GlobalPreferences
fi
if [ ! -d TheWikipediaLibrary ]; then
git clone ssh://gerrit.wikimedia.org:29418/mediawiki/extensions/TheWikipediaLibrary.git
fi
cd /vagrant/mediawiki
# run migrations for extensions
sudo -i bash -c "mysql < /vagrant/twl.sql;"
mwscript maintenance/sql.php --wikidb centralauth extensions/CentralAuth/central-auth.sql;
mwscript maintenance/sql.php --wikidb centralauth extensions/GlobalPreferences/sql/mysql/tables-generated.sql;
mwscript extensions/CentralAuth/maintenance/migratePass0.php
mwscript extensions/CentralAuth/maintenance/migratePass1.php
mwscript maintenance/update.php --quick;
