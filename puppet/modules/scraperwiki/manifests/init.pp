# Init for ScraperWiki setup
class scraperwiki {

  include scraperwiki::requirements

  $repository = 'https://bitbucket.org/ScraperWiki/scraperwiki'
  $root_dir = '/opt/scraperwiki'

  $python_dependencies = [
    'pip',
    'distribute',
    'zc.buildout',
  ]

  package {
    $python_dependencies:
      ensure   => 'latest',
      provider => 'pip',
      require  => Package['python-pip'],
    ;
  }

  exec {
    'buildout-dev':
      command   => '/usr/local/bin/buildout -v -c buildout_dev.cfg',
      cwd       => $root_dir,
      timeout   => 0,
      logoutput => true,
      require   => Exec['buildout'],
    ;

    'buildout':
      command   => '/usr/local/bin/buildout -v',
      cwd       => $root_dir,
      timeout   => 0,
      logoutput => true,
      require   => [Exec['scraperwiki root dir'], Package['distribute'], Package['zc.buildout']],
    ;

    'hg clone':
      command => "/usr/bin/hg clone ${repository} ${root_dir}",
      creates => "${root_dir}/.hg",
      require => Exec['scraperwiki root dir'],
    ;

    'scraperwiki root dir':
      command => "/bin/mkdir -p ${root_dir}",
    ;
  }

}
