# == Class: role_col::annualchecklist
#
#

class role_col::annualchecklist(
# Appsettings
  $apphash                                = {'annual-checklist/2005' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2005'},
                                             'annual-checklist/2006' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2006'},
                                             'annual-checklist/2007' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2007'},
                                             'annual-checklist/2008' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2008'},
                                             'annual-checklist/2009' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2009'},
                                             'annual-checklist/2010' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2010'},
                                             'annual-checklist/2011' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2011'},
                                             'annual-checklist/dnp2011' => { 'appfolder' => '/var/www/htdocs/annual-checklist/dnp2011'},
                                             'annual-checklist/2013' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2013'},
                                             'annual-checklist/2014' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2014'},
                                             'annual-checklist/2012' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2012'},
                                             'annual-checklist/2015' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2015'},
                                             'annual-checklist/2016' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2016'},
                                             'annual-checklist/dnp2012' => { 'appfolder' => '/var/www/htdocs/annual-checklist/dnp2012'},
                                             'annual-checklist/2017' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2017'},
                                             'annual-checklist/2018' => { 'appfolder' => '/var/www/htdocs/annual-checklist/2018'}
                                            },
# Apache Settings
  $instances                              = 
            {'www.catalogueoflife.org' => {
            'serveraliases'   => 'www.catalogueoflife.com',
            'docroot'         => '/var/www/htdocs',
            'directories'     => [{ 'path' => '/var/www/htdocs', 'options' => '-Indexes +FollowSymLinks +MultiViews', 'allow_override' => 'All' },
                                  { 'path' => '/var/www/htdocs/webservice/annual-checklist', 'directoryindex' => 'index.php search.php', 'options' => '-Indexes +FollowSymLinks -MultiViews', 'allow_override' => 'All' },
                                  { 'path' => '/var/www/htdocs/annual-checklist', 'directoryindex' => 'index.php search.php', 'options' => '-Indexes +FollowSymLinks -MultiViews', 'allow_override' => 'All' }],
            'port'            => 80,
            'serveradmin'     => 'webmaster@naturalis.nl',
            'priority'        => 10,
            'redirectmatch_regexp' => ['/annual-checklist$','/annual-checklist/$'],
            'redirectmatch_dest'   => ['/annual-checklist/2018','/annual-checklist/2018'],
            'redirectmatch_status' => ['permanent','permanent'],
            'aliases'         => [{ alias => '/webservice/annual-checklist/2007', path => '/var/www/htdocs/webservice/annual-checklist/2007/' },
                                  { alias => '/annual-checklist/2007/webservice', path => '/var/www/htdocs/webservice/annual-checklist/2007/' },
                                  { alias => '/webservice/annual-checklist/2008', path => '/var/www/htdocs/webservice/annual-checklist/2008/' },
                                  { alias => '/annual-checklist/2008/webservice', path => '/var/www/htdocs/webservice/annual-checklist/2008/' },
                                  { alias => '/webservice/annual-checklist/2009', path => '/var/www/htdocs/webservice/annual-checklist/2009/' },
                                  { alias => '/annual-checklist/2009/webservice', path => '/var/www/htdocs/webservice/annual-checklist/2009/' },
                                  { alias => '/annual-checklist/2005', path => '/var/www/htdocs/annual-checklist/2005/' },
                                  { alias => '/annual-checklist/2006', path => '/var/www/htdocs/annual-checklist/2006/' },
                                  { alias => '/annual-checklist/2007', path => '/var/www/htdocs/annual-checklist/2007/' },
                                  { alias => '/annual-checklist/2008', path => '/var/www/htdocs/annual-checklist/2008/' },
                                  { alias => '/annual-checklist/2009', path => '/var/www/htdocs/annual-checklist/2009/' },
                                  { alias => '/annual-checklist/2010', path => '/var/www/htdocs/annual-checklist/2010/public/' },
                                  { alias => '/annual-checklist/2011', path => '/var/www/htdocs/annual-checklist/2011/public/' },
                                  { alias => '/annual-checklist/2012', path => '/var/www/htdocs/annual-checklist/2012/public/' },
                                  { alias => '/annual-checklist/dnp2011', path => '/var/www/htdocs/annual-checklist/dnp2011/public/' },
                                  { alias => '/webservice/annual-checklist/dnp2011', path => '/var/www/htdocs/webservice/annual-checklist/dnp2011/' },
                                  { alias => '/annual-checklist/dnp2012', path => '/var/www/htdocs/annual-checklist/dnp2012/public/' },
                                  { alias => '/webservice/annual-checklist/dnp2012', path => '/var/www/htdocs/webservice/annual-checklist/dnp2012/' },
                                  { alias => '/annual-checklist/2013', path => '/var/www/htdocs/annual-checklist/2013/public/' },
                                  { alias => '/webservice/annual-checklist/2013', path => '/var/www/htdocs/webservice/annual-checklist/2013/' },
                                  { alias => '/annual-checklist/2014', path => '/var/www/htdocs/annual-checklist/2014/public/' },
                                  { alias => '/webservice/annual-checklist/2014', path => '/var/www/htdocs/webservice/annual-checklist/2014/' },
                                  { alias => '/annual-checklist/2015', path => '/var/www/htdocs/annual-checklist/2015/public/' },
                                  { alias => '/webservice/annual-checklist/2015', path => '/var/www/htdocs/webservice/annual-checklist/2015/' },
                                  { alias => '/annual-checklist/2016', path => '/var/www/htdocs/annual-checklist/2016/public/' },
                                  { alias => '/webservice/annual-checklist/2016', path => '/var/www/htdocs/webservice/annual-checklist/2016/' },
                                  { alias => '/annual-checklist/2017', path => '/var/www/htdocs/annual-checklist/2017/public/' },
                                  { alias => '/webservice/annual-checklist/2017', path => '/var/www/htdocs/webservice/annual-checklist/2017/' },
                                  { alias => '/annual-checklist/2018', path => '/var/www/htdocs/annual-checklist/2018/public/' },
                                  { alias => '/webservice/annual-checklist/2018', path => '/var/www/htdocs/webservice/annual-checklist/2018/' },
                                 ],
                                        },
            'webservice.catalogueoflife.org' => {
            'serveraliases'   => 'webservice.catalogueoflife.com',
            'docroot'         => '/var/www/htdocs',
            'directories'     => [{ 'path' => '/var/www/htdocs/webservice/annual-checklist', 'directoryindex' => 'index.php search.php', 'options' => '-Indexes +FollowSymLinks -MultiViews', 'allow_override' => 'All' },
                                  { 'path' => '/var/www/htdocs/annual-checklist', 'directoryindex' => 'index.php search.php', 'options' => '-Indexes +FollowSymLinks -MultiViews', 'allow_override' => 'All' }],
            'port'            => 80,
            'serveradmin'     => 'webmaster@naturalis.nl',
            'priority'        => 15,
            'redirectmatch_regexp' => ['/annual-checklist$',
                                       '/annual-checklist/$',
                                       '/annual-checklist/webservice$',
                                       '/annual-checklist/([0-9][0-9][0-9][0-9])$',
                                       '/annual-checklist/([0-9][0-9][0-9][0-9])/$',
                                       '/annual-checklist/([a-z][a-z][a-z][0-9][0-9][0-9][0-9])$',
                                       '/annual-checklist/([a-z][a-z][a-z][0-9][0-9][0-9][0-9])/$'],
            'redirectmatch_dest'   => ['/annual-checklist/2018/webservice',
                                       '/annual-checklist/2018/webservice',
                                       '/annual-checklist/$1/webservice',
                                       '/annual-checklist/$1/webservice',
                                       '/annual-checklist/$1/webservice',
                                       '/annual-checklist/$1/webservice'],
            'redirectmatch_status' => ['permanent',
                                       'permanent',
                                       'permanent',
                                       'permanent',
                                       'permanent',
                                       'permanent'],
            'aliases'         => [{ alias => '/webservice/annual-checklist/2007', path => '/var/www/htdocs/webservice/annual-checklist/2007/' },
                                  { alias => '/annual-checklist/2007/webservice', path => '/var/www/htdocs/webservice/annual-checklist/2007/' },
                                  { alias => '/webservice/annual-checklist/2008', path => '/var/www/htdocs/webservice/annual-checklist/2008/' },
                                  { alias => '/annual-checklist/2008/webservice', path => '/var/www/htdocs/webservice/annual-checklist/2008/' },
                                  { alias => '/webservice/annual-checklist/2009', path => '/var/www/htdocs/webservice/annual-checklist/2009/' },
                                  { alias => '/annual-checklist/2009/webservice', path => '/var/www/htdocs/webservice/annual-checklist/2009/' },
                                  { alias => '/annual-checklist/2012', path => '/var/www/htdocs/annual-checklist/2012/public/' },
                                  { alias => '/annual-checklist/2005', path => '/var/www/htdocs/annual-checklist/2005/' },
                                  { alias => '/annual-checklist/2006', path => '/var/www/htdocs/annual-checklist/2006/' },
                                  { alias => '/annual-checklist/2007', path => '/var/www/htdocs/annual-checklist/2007/' },
                                  { alias => '/annual-checklist/2008', path => '/var/www/htdocs/annual-checklist/2008/' },
                                  { alias => '/annual-checklist/2009', path => '/var/www/htdocs/annual-checklist/2009/' },
                                  { alias => '/annual-checklist/2010', path => '/var/www/htdocs/annual-checklist/2010/public/' },
                                  { alias => '/annual-checklist/2011', path => '/var/www/htdocs/annual-checklist/2011/public/' },
                                  { alias => '/annual-checklist/dnp2011', path => '/var/www/htdocs/annual-checklist/dnp2011/public/' },
                                  { alias => '/webservice/annual-checklist/dnp2011', path => '/var/www/htdocs/webservice/annual-checklist/dnp2011/' },
                                  { alias => '/annual-checklist/dnp2012', path => '/var/www/htdocs/annual-checklist/dnp2012/public/' },
                                  { alias => '/webservice/annual-checklist/dnp2012', path => '/var/www/htdocs/webservice/annual-checklist/dnp2012/' },
                                  { alias => '/annual-checklist/2013', path => '/var/www/htdocs/annual-checklist/2013/public/' },
                                  { alias => '/webservice/annual-checklist/2013', path => '/var/www/htdocs/webservice/annual-checklist/2013/' },
                                  { alias => '/annual-checklist/2014', path => '/var/www/htdocs/annual-checklist/2014/public/' },
                                  { alias => '/webservice/annual-checklist/2014', path => '/var/www/htdocs/webservice/annual-checklist/2014/' },
                                  { alias => '/annual-checklist/2015', path => '/var/www/htdocs/annual-checklist/2015/public/' },
                                  { alias => '/webservice/annual-checklist/2015', path => '/var/www/htdocs/webservice/annual-checklist/2015/' },
                                  { alias => '/annual-checklist/2016', path => '/var/www/htdocs/annual-checklist/2016/public/' },
                                  { alias => '/webservice/annual-checklist/2016', path => '/var/www/htdocs/webservice/annual-checklist/2016/' },
                                  { alias => '/annual-checklist/2017', path => '/var/www/htdocs/annual-checklist/2017/public/' },
                                  { alias => '/webservice/annual-checklist/2017', path => '/var/www/htdocs/webservice/annual-checklist/2017/' },
                                  { alias => '/annual-checklist/2018', path => '/var/www/htdocs/annual-checklist/2018/public/' },
                                  { alias => '/webservice/annual-checklist/2018', path => '/var/www/htdocs/webservice/annual-checklist/2018/' },
                                 ],
                              },
                            },
){

# install php modules
  class { 'role_col::php': }

  file { '/var/lib/php':
    ensure      => 'directory',
    mode        => '750',
    owner       => 'root',
    group       => 'www-data',
  }

  file { '/var/lib/php/session':
    ensure      => 'directory',
    mode        => '770',
    owner       => 'root',
    group       => 'www-data',
    require     => File['/var/lib/php']
  }

# Install apache and enable modules
  class { 'apache':
    default_mods              => true,
    mpm_module                => 'prefork',
    keepalive                 => $role_col::conf::keepalive,
    max_keepalive_requests    => $role_col::conf::max_keepalive_requests,
    keepalive_timeout         => $role_col::conf::keepalive_timeout,
    default_vhost             => false,
  }
  class {'apache::mod::php':
     php_version => '7.1',
  }
  include apache::mod::rewrite
  include apache::mod::speling

  class { 'role_col::instances':
    instances                   => $instances,
  }

# install DB
  class { 'role_col::db': }

# General repo settings
  class { 'role_col::repogeneral': }

# Configure apps
  file { 'approot':
    path        => '/var/www/htdocs/annual-checklist',
    ensure      => 'directory',
    mode        => '750',
    owner       => 'root',
    group       => 'www-data',
  }

  create_resources('role_col::confapp',$apphash)

}
