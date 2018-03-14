# == Class: role_col::annualchecklist
#
#

class role_col::annualchecklist(
  $extra_packages                         = undef,
  $gitrepos                               = undef,
#    [
#  {'examplerepo1' => {
#           'reposource'   => 'git@github.com:naturalis/examplerepo1.git',
#           'repokey'      => 'PRIVATE KEY here',
#         },
#       },
#  {'examplerepo2' => {
#            'reposource'   => 'git@github.com:naturalis/examplerepo2.git',
#            'repokey'      => 'PRIVATE KEY here',
#   },
# },
#    ],

# PHP Settings
  $php_memory_limit                       = '128M',
  $upload_max_filesize                    = '16M',
  $post_max_size                          = '16M',
  $max_execution_time                     = '30',
  $max_input_time                         = '60',

# Mysql Settings
  $mysql_root_password                    = 'rootpassword',
  $mysql_manage_config_file               = true,
  $mysql_key_buffer_size                  = 1G,
  $mysql_max_allowed_package              = 16M,
  $mysql_thread_stack                     = 192K,
  $mysql_thread_cachesize                 = 8,
  $mysql_query_cache_limit                = 16M,
  $mysql_query_cache_size                 = 256M,
  $mysql_innodb_buffer_pool_size          = 512M,
  $mysql_innodb_additional_mem_pool_size  = 512M,
  $mysql_innodb_log_buffer_size           = 256M,
  $mysql_max_connections                  = 1024,
  $mysql_max_heap_table_size              = 128M,
  $mysql_lower_case_table_names           = undef,  # nog een probleem
  $mysql_innodb_file_per_table            = '1',
  $mysql_tmp_table_size                   = 128M,
  $mysql_table_open_cache                 = 450,
  $mysql_table_cache                      = 128,
  $mysql_sql_mode                         = 'TRADITIONAL',
  $mysql_long_query_time                  = 5,
  $mysql_slow_query_log                   = 1,
  $mysql_slow_query_log_file              = '/var/log/mysql/mysql-slow.log',
  $mysql_general_log                      = 'off',
  $mysql_character_set_server             = 'utf8',
  $mysql_collation_server                 = 'utf8_general_ci',
  $mysql_connect_timeout                  = 3,
  $mysql_wait_timeout                     = 30,

# Appsettings
  $apphash                                = {'app_001' => { 'appfolder' => 'annual-checklist/2005'},
                                             'app_002' => { 'appfolder' => 'annual-checklist/2006'},
                                             'app_003' => { 'appfolder' => 'annual-checklist/2007'},
                                             'app_004' => { 'appfolder' => 'annual-checklist/2008'},
                                             'app_005' => { 'appfolder' => 'annual-checklist/2009'},
                                             'app_006' => { 'appfolder' => 'annual-checklist/2010'},
                                             'app_007' => { 'appfolder' => 'annual-checklist/2011'},
                                             'app_008' => { 'appfolder' => 'annual-checklist/dnp2011'},
                                             'app_010' => { 'appfolder' => 'annual-checklist/2013'},
                                             'app_011' => { 'appfolder' => 'annual-checklist/2014'},
                                             'app_012' => { 'appfolder' => 'annual-checklist/2012'},
                                             'app_013' => { 'appfolder' => 'annual-checklist/2015'},
                                             'app_014' => { 'appfolder' => 'annual-checklist/2016'},
                                             'app_015' => { 'appfolder' => 'annual-checklist/dnp2012'},
                                             'app_016' => { 'appfolder' => 'annual-checklist/2017'}
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
            'redirectmatch_dest'   => ['/annual-checklist/2017','/annual-checklist/2017'],
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
            'redirectmatch_dest'   => ['/annual-checklist/2017/webservice',
                                       '/annual-checklist/2017/webservice',
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
                                 ],
                              },
                            },
  $keepalive                            = 'On',
  $max_keepalive_requests               = '100',
  $keepalive_timeout                    = '1500',
  $timeout                              = '3600'
){

# install php modules
  php::module { [ 'mysql','curl','apc' ]: }

  php::ini { '/etc/php5/apache2/php.ini':
    memory_limit              => $php_memory_limit,
    upload_max_filesize       => $upload_max_filesize,
    post_max_size             => $post_max_size,
    max_execution_time        => $max_execution_time,
    max_input_time            => $max_input_time,
    require                   => Class['apache']
  }

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
    keepalive                 => $keepalive,
    max_keepalive_requests    => $max_keepalive_requests,
    keepalive_timeout         => $keepalive_timeout,
    default_vhost             => false,
  }

  include apache::mod::php
  include apache::mod::rewrite
  include apache::mod::speling

  class { 'role_col::instances':
    instances                   => $instances,
  }

# Configure MySQL Security and finetuning if needed
  class { 'mysql::server::account_security':}
  class { 'mysql::server':
      root_password         => $mysql_root_password,
      service_enabled       => true,
      service_manage        => true,
      manage_config_file    => $mysql_manage_config_file,
      override_options      => {
        'mysqld'            => {
          'key_buffer_size'                 => $mysql_key_buffer_size,
          'query_cache_limit'               => $mysql_query_cache_limit,
          'query_cache_size'                => $mysql_query_cache_size,
          'innodb_buffer_pool_size'         => $mysql_innodb_buffer_pool_size,
          'innodb_additional_mem_pool_size' => $mysql_innodb_additional_mem_pool_size,
          'innodb_log_buffer_size'          => $mysql_innodb_log_buffer_size,
          'max_connections'                 => $mysql_max_connections,
          'max_heap_table_size'             => $mysql_max_heap_table_size,
          'lower_case_table_names'          => $mysql_lower_case_table_names,
          'innodb_file_per_table'           => $mysql_innodb_file_per_table,
          'tmp_table_size'                  => $mysql_tmp_table_size,
          'table_open_cache'                => $mysql_table_open_cache,
          'table_cache'                     => $mysql_table_cache,
          'sql_mode'                        => $mysql_sql_mode,
          'long_query_time'                 => $mysql_long_query_time,
          'slow_query_log'                  => $mysql_slow_query_log,
          'slow_query_log_file'             => $mysql_slow_query_log_file,
          'character_set_server'            => $mysql_character_set_server,
          'collation_server'                => $mysql_collation_server,
          'connect_timeout'                 => $mysql_connect_timeout,
          'thread_stack'                    => $mysql_thread_stack,
          'thread_cache_size'               => $mysql_thread_cachesize,
          'connect_timeout'                 => $mysql_connect_timeout,
          'wait_timeout'                    => $mysql_wait_timeout,
          'general_log'                     => $mysql_general_log,
      }
    }
  }

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





# Check out repositories
#  create_resources('role_col::repo', $repos)

# install extra packages
#  package { $extra_packages:
#    ensure => installed,
#  }

}
