# Installs required packages for ScraperWiki
class scraperwiki::requirements {

  $required_packages = [
    'make',
    'curl',
    'g++',
    'mercurial',
    'php5',
    'ruby1.9.1',
    'python-virtualenv',
    'python-dev',
    'python-m2crypto',
    'mysql-server',
    'libmysqlclient-dev',
    'git-core',
    'libjson-ruby',
    'libxml2-dev',
    'libxslt-dev',
    'libssl-dev',
    'swig',
  ]

  exec {
    'apt-get update':
      command => '/usr/bin/apt-get update',
      #      onlyif  => '[[ $(( $(date +%s) - $(stat -c %Z /var/cache/apt/pkgcache.bin) )) -gt $(( 24 * 60 * 60 )) ]]',
    ;
  }

  package {
    $required_packages:
      ensure  => 'latest',
      require => Exec['apt-get update'],
    ;
  }

}
