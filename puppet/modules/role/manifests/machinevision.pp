# == Class: role::machinevision
# Installs the MachineVision[1] extension which supports collecting data about
# Commons images from internal and external machine vision services and storing
# it for on-wiki usage.
#
# [1] https://www.mediawiki.org/wiki/Extension:MachineVision
#
class role::machinevision {
    include ::role::mediainfo

    mediawiki::extension { 'MachineVision':
        needs_update => true,
        composer     => true,
    }

    mediawiki::import::text { 'VagrantRoleMachineVision':
        content => template('role/machinevision/VagrantRoleMachineVision.wiki.erb'),
    }

    apache::site_conf { 'Google Cloud Vision API credentials':
        site    => $::mediawiki::wiki_name,
        content => template('role/machinevision/apache2.conf.erb'),
    }
}

