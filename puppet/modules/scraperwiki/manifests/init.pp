# Init for ScraperWiki setup
class scraperwiki {

  include scraperwiki::requirements

  $repository = 'https://bitbucket.org/ScraperWiki/scraperwiki'
  $root_dir = '/opt/scraperwiki'

  $python_dependencies = [
    'distribute',
    'zc.buildout',
  ]

  package {
    $python_dependencies:
      provider => 'pip',
      ensure   => 'latest',
    ;
  }

  exec {
    'buildout':
      command   => 'buildout',
      cwd       => $root_dir,
      timeout   => 0,
      logoutput => true,
      provider  => 'shell',
      require   => [Package['distribute'], Package['zc.buildout']],
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
