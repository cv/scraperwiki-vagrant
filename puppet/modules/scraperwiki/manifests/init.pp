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
      provider => 'pip',
      ensure   => 'latest',
      root     => $root_dir,
    ;
  }

  exec {
    'virtualenv':
      command   => 'virtualenv --no-site-packages .',
      cwd       => $root_dir,
      logoutput => true,
      provider  => 'shell',
      require   => Exec['scraperwiki root dir'],
    ;

    'buildout-dev':
      command   => '. bin/activate && buildout -c buildout_dev.cfg',
      cwd       => $root_dir,
      timeout   => 0,
      logoutput => true,
      provider  => 'shell',
      require   => Exec['buildout-dev'],
    ;

    'buildout':
      command   => '. bin/activate && buildout',
      cwd       => $root_dir,
      timeout   => 0,
      logoutput => true,
      provider  => 'shell',
      require   => [Exec['virtualenv'], Package['distribute'], Package['zc.buildout']],
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
