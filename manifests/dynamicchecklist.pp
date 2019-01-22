# == Class: role_col::dynamicchecklist
#
#

class role_col::dynamicchecklist(
# Appsettings
  $apphash                                = {'newcol' => { 'appfolder' => '/data/git/AC_Interface',
                                                           'link'      => '/var/www/htdocs/newcol' },
                                             'col'    => { 'appfolder' => '/var/www/htdocs/col'}
                                            },
# Apache Settings
  $instances                              = 
            {'www.catalogueoflife.org' => {
            'serveraliases'   => 'www.catalogueoflife.com',
            'docroot'         => '/var/www/htdocs',
            'directories'     => [{ 'path' => '/var/www/htdocs', 'options' => '-Indexes +FollowSymLinks +MultiViews', 'allow_override' => 'All' },
                                  { 'path' => '/var/www/htdocs/listmatching', 'directoryindex' => 'list_matching_form.php', 'options' => '-Indexes +FollowSymLinks +MultiViews', 'allow_override' => 'All' }],
            'port'            => 80,
            'serveradmin'     => 'webmaster@naturalis.nl',
            'priority'        => 10,
            'redirectmatch_regexp' => ['/dynamic-checklist$','/dynamic-checklist/$'],
            'redirectmatch_dest'   => ['/col','/col/'],
            'redirectmatch_status' => ['permanent','permanent'],
            'aliases'         => [{ alias => '/DCA_Export/webservice', path => '/var/www/htdocs/DCA_Webservice_v1.3/public/' },
#                                 { alias => '/DCA_Export', path => '/var/www/htdocs/DCA_Export_v1.3/' },
                                  { alias => '/webservices', path => '/var/www/htdocs/webservices/public/' },
                                  { alias => '/dynamic-checklist', path => '/var/www/htdocs/col/public' },
                                  { alias => '/col', path => '/var/www/htdocs/col/public/' },
                                  { alias => '/newcol', path => '/var/www/htdocs/newcol/public/' },
                                  { alias => '/listmatching', path => '/var/www/htdocs/listmatching/' }
                                 ],
                                        },
            'webservice.catalogueoflife.org' => {
            'serveraliases'   => 'webservice.catalogueoflife.com',
            'docroot'         => '/var/www/htdocs',
            'directories'     => [{ 'path' => '/var/www/htdocs', 'options' => '-Indexes +FollowSymLinks +MultiViews', 'allow_override' => 'All' }],
            'port'            => 80,
            'serveradmin'     => 'webmaster@naturalis.nl',
            'priority'        => 15,
            'redirectmatch_regexp' => ['^/$'],
            'redirectmatch_dest'   => ['/col/webservice'],
            'redirectmatch_status' => ['permanent'],
            'aliases'         => [{ alias => '/DCA_Export/webservice', path => '/var/www/htdocs/DCA_Webservice_v1.3/public/' },
#                                  { alias => '/DCA_Export', path => '/var/www/htdocs/DCA_Export_v1.3/' },
                                  { alias => '/webservices', path => '/var/www/htdocs/webservices/public/' },
                                  { alias => '/webservice', path => '/var/www/htdocs/webservice/public/' },
                                  { alias => '/dynamic-checklist', path => '/var/www/htdocs/col/public' },
                                  { alias => '/col', path => '/var/www/htdocs/col/public/' },
                                  { alias => '/listmatching', path => '/var/www/htdocs/listmatching/' }
                                 ],
                              },
                            },
){

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
    path        => '/var/www/htdocs/col2',
    ensure      => 'directory',
    mode        => '750',
    owner       => 'root',
    group       => 'www-data',
  }

  create_resources('role_col::confapp',$apphash)

# Dynamic Checklist update code
  class { 'role_col::dynamicupdate': }


}
