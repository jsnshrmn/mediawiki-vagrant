# == Class: proton
# Sets up the Proton[1] service which renders PDF files from web pages.
#
# [1] https://www.mediawiki.org/wiki/Proton
#
# === Parameters
#
# [*port*]
#   The port proton listens
#
# [*dir*]
#   Service directory
#
# [*log_file*]
#   Log file for electron and xvfb.
#
class proton(
    $port,
    $dir,
    $log_file,
) {
    include ::git
    require ::role::mediawiki

    require_package([
        'chromium',
        'fonts-liberation',
        'fonts-noto',
    ])

    service::node { 'proton':
        port        => $port,
        git_remote  => sprintf($::git::urlformat, 'mediawiki/services/chromium-render'),
        config      => template('proton/config.yaml.erb'),
        environment => {
            'APP_ENABLE_CANCELLABLE_PROMISES' => true,
            'PUPPETEER_EXECUTABLE_PATH'       => '/usr/bin/chromium',
        },
        require     => Package['chromium', 'fonts-liberation', 'fonts-noto'],
    }
}
