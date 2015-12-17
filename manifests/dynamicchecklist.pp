# == Class: role_col::dynamicchecklist
#
#

class role_col::dynamicchecklist(
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
  $mysql_log                              = '/var/log/mysql/mysql.log',
  $mysql_character_set_server             = 'utf8',
  $mysql_collation_server                 = 'utf8_general_ci',
  $mysql_connect_timeout                  = 3,
  $mysql_wait_timeout                     = 30,

# Appsettings
  $apphash                                = {'app_001' => { 'appfolder' => 'col'},
                                             'app_002' => { 'appfolder' => 'newcol'}
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
                                  { alias => '/DCA_Export', path => '/var/www/htdocs/DCA_Export_v1.3/' },
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
                                  { alias => '/DCA_Export', path => '/var/www/htdocs/DCA_Export_v1.3/' },
                                  { alias => '/webservices', path => '/var/www/htdocs/webservices/public/' },
                                  { alias => '/webservice', path => '/var/www/htdocs/webservice/public/' },
                                  { alias => '/dynamic-checklist', path => '/var/www/htdocs/col/public' },
                                  { alias => '/col', path => '/var/www/htdocs/col/public/' },
                                  { alias => '/listmatching', path => '/var/www/htdocs/listmatching/' }
                                 ],
                              },
                            },
  $keepalive                            = 'On',
  $max_keepalive_requests               = '100',
  $keepalive_timeout                    = '1500',
  $timeout                              = '3600',

# Update Settings
  $workspace_dir                        = '/opt/colupdate',
  $download_ip                          = '162.1.1.1',
  $download_user                        = 'download',
  $download_password                    = 'downloadpass',
  $dcupdate_password                    = 'dcupdatapass',
  $update_hour                          = '14'
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
          'log'                             => $mysql_log,
          'character_set_server'            => $mysql_character_set_server,
          'collation_server'                => $mysql_collation_server,
          'connect_timeout'                 => $mysql_connect_timeout,
          'thread_stack'                    => $mysql_thread_stack,
          'thread_cache_size'               => $mysql_thread_cachesize,
          'connect_timeout'                 => $mysql_connect_timeout,
          'wait_timeout'                    => $mysql_wait_timeout,
      }
    }
  }

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




# Check out repositories
#  create_resources('role_col::repo', $repos)

# install extra packages
#  package { $extra_packages:
#    ensure => installed,
#  }

}
