# == Class: role_col::workbench
#
#

class role_col::workbench(
  $extra_users_hash     = undef,
  $packages             = ['subversion','perl','libnet-ssleay-perl','openssl','libauthen-pam-perl','libpam-runtime','libio-pty-perl','mdbtools','zip','smarty'],
  $webdirs              = ['/var/www/piping','/var/www/piping/webservice','/var/www/piping/php'],
  $rwwebdirs            = ['/var/www/piping/log'],
  $instances            = {'www.catalogueoflife.com' => {
                                   'serveraliases'   => 'www.catalogueoflife.org',
                                   'aliases'         => [{ 'alias' => '/piping/webservice', 'path' => '/var/www/piping/webservice' },
                                                         { 'alias' => '/piping_devel/webservice', 'path' => '/var/www/piping_devel/webservice' },
                                                         { 'alias' => '/piping_devel', 'path' => '/var/www/piping_devel/php' },
                                                         { 'alias' => '/piping_new/webservice', 'path' => '/var/www/piping_new/webservice' },
                                                         { 'alias' => '/piping_new', 'path' => '/var/www/piping_devel/php' },
                                                         { 'alias' => '/testcol', 'path' => '/var/www/testcol/public' },
                                                         { 'alias' => '/exposed', 'path' => '/var/www/exposed' },
                                                         { 'alias' => '/phpharvester', 'path' => '/var/www/phpharvester' },
                                                         { 'alias' => '/var/www/download', 'path' => '/var/www/download' },
                                                         { 'alias' => '/piping', 'path' => '/var/www/piping/php' }],
                                   'docroot'         => '/var/www',
                                   'directories'     => [{ 'path' => '/var/www', 'options' => '-Indexes FollowSymLinks -MultiViews', 'allow_override' => 'All' },
                                                         { 'path' => '/var/www/piping/webservice', 'options' => 'Indexes FollowSymLinks -MultiViews', 'allow_override' => 'All' },
                                                         { 'path' => '/var/www/piping_devel/webservice', 'options' => 'Indexes FollowSymLinks -MultiViews', 'allow_override' => 'All' },
                                                         { 'path' => '/var/www/piping_new/webservice', 'options' => 'Indexes FollowSymLinks -MultiViews', 'allow_override' => 'All' },
                                                         { 'path' => '/var/www/download', 'options' => 'Indexes FollowSymLinks -MultiViews', 'allow_override' => 'All' }],
                                   'port'            => 80,
                                   'serveradmin'     => 'aut@naturalis.nl',
                                   'priority'        => 10,
                                   },
                       },
  $mysqlUser            = 'mysqluser',
  $mysqlPassword        = 'mysqlpasswd',
  $mysqlRootPassword    = 'mysqlrootpwd',
)
{

  apt::source { 'webmin_main':
    location    => 'http://download.webmin.com/download/repository',
    release     => 'sarge',
    repos       => 'contrib',
    key         => '1B24BE83',
    key_source  => 'http://www.webmin.com/jcameron-key.asc',
    include_src => false,
  }->
  package {'webmin':
    ensure      => 'installed'
  }->
  package {'usermin':
    ensure      => 'installed'
  }

  service { 'webmin':
    ensure      => "running",
    require     => Package['webmin']
  }

  service { 'usermin':
    ensure      => "running",
    require     => Package['webmin']
  }

# Create symlink for webmin backwards compatibility
  file { '/usr/libexec':
    ensure      => 'directory',
  }->
  file { '/usr/libexec/webmin':
    ensure      => 'link',
    target      => '/usr/share/webmin',
    require     => Package['webmin']
  }

  package { $packages:
    ensure      => "installed"
  }
  
 # install apache
  class { 'apache':
    default_mods => true,
    mpm_module => 'prefork',
  }
  include apache::mod::php
  include apache::mod::rewrite

  class { 'role_col::instances': 
    instances => $instances,
  }

  # create application specific directories  
  file { $webdirs:
    ensure  => 'directory',
    mode    => '0755',
  }

  file { $rwwebdirs:
    ensure  => 'directory',
    mode    => '0660',
    owner   => root,
    group   => 'www-data',
    recurse     => true,
    require     => File[$webdirs],
  }

  # create extra users
  if $extra_users_hash {
    create_resources('base::users', parseyaml($extra_users_hash))
  }

  class { 'role_col::workbenchdb':
    databases     => ''
  }

}
