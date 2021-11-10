#!/usr/bin/env bash

# download extensions
cd /vagrant/mediawiki/extensions/
if [ ! -d Renameuser ]; then
    clone git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Renameuser
fi
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
    echo "Please clone TheWikipediaLibrary to mediawiki/extensions" >>/dev/stderr
    exit 1
fi

# require extensions
cp /vagrant/00-Twl.php /vagrant/settings.d/

# run migrations for extensions
cd /vagrant/mediawiki
sudo -i bash -c "mysql < /vagrant/twl.sql;"
mwscript maintenance/sql.php --wikidb centralauth extensions/CentralAuth/central-auth.sql
mwscript maintenance/sql.php --wikidb centralauth extensions/GlobalPreferences/sql/mysql/tables-generated.sql
mwscript extensions/CentralAuth/maintenance/migratePass0.php
mwscript extensions/CentralAuth/maintenance/migratePass1.php
mwscript maintenance/update.php --quick
