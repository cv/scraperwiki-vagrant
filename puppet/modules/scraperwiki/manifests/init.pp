# Init for ScraperWiki setup
class scraperwiki {

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
    'mysql-server',
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
    ;
  }

  package {
    $required_packages:
      ensure  => 'latest',
      require => Exec['apt-get update'],
    ;
  }

}
