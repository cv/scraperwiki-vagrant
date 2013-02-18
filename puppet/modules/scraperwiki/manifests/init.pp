# Init for ScraperWiki setup
class scraperwiki {

  include scraperwiki::requirements

  $repository = 'https://bitbucket.org/ScraperWiki/scraperwiki'
  $root_dir = '/opt/scraperwiki'

  exec {
    'hg clone':
      command => "/usr/bin/hg clone ${repository} ${root_dir}",
      require => Exec['scraperwiki root dirs'],
    ;

    'scraperwiki root dirs':
      command => "mkdir -p ${root_dir}",
    ;
  }

}
