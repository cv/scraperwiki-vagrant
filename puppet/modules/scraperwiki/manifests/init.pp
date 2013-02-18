# Init for ScraperWiki setup
class scraperwiki {

  include scraperwiki::requirements

  $repository = 'https://bitbucket.org/ScraperWiki/scraperwiki'
  $root_dir = '/opt/scraperwiki'

  exec {
    'buildout':
      command   => '/bin/bash -c "source bin/activate && /usr/bin/pip install zc.buildout && buildout"',
      cwd       => $root_dir,
      timeout   => 0,
      logoutput => true,
      require   => Exec['update distribute'],
    ;

    'update distribute':
      command => '/bin/bash -c "source bin/activate && easy_install -U distribute"',
      cwd     => $root_dir,
      require => Exec['virtualenv'],
    ;

    'virtualenv':
      command => '/usr/bin/virtualenv --no-site-packages .',
      cwd     => $root_dir,
      require => Exec['hg clone'],
    ;

    'hg clone':
      command => "/usr/bin/hg clone ${repository} ${root_dir}",
      creates => "${root_dir}/.hg",
      require => Exec['scraperwiki root dirs'],
    ;

    'scraperwiki root dirs':
      command => "/bin/mkdir -p ${root_dir}",
    ;
  }


}
