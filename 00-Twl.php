<?php

wfLoadExtension( 'Echo' );
wfLoadExtension( 'GlobalPreferences' );
wfLoadExtension( 'Renameuser' );
$wgGroupPermissions['sysop']['renameuser'] = true;
wfLoadExtension( 'CentralAuth' );
wfLoadExtension( 'TheWikipediaLibrary' );
# No need to set $wgGlobalPreferencesDB if it's the same as $wgSharedDB.
# But setting $wgSharedDB seems to make sqlite-backed mediawiki angry.
$wgCentralAuthDatabase = 'centralauth';
#$wgSharedDB = 'centralauth';
$wgGlobalPreferencesDB = 'centralauth';
#$wgEchoCrossWikiNotifications = true;
$wgTwlSendNotifications = true;
$wgTwlEditCount = 2;
$wgTwlRegistrationDays = 0;

