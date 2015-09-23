# == Class: role_col::annualchecklist
#
#

class role_col::annualchecklist(
  $services                               = ['mysqld','httpd','sshd'],
  $extra_packages                         = ['sysstat'],
  $gitrepos                               =
    [
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
    ],

# PHP Settings
  $php_memory_limit                       = '512M',
  $upload_max_filesize                    = '256M',
  $post_max_size                          = '384M',
  $max_execution_time                     = '-1',
  $max_input_vars                         = '213000',
  $max_input_time                         = '6000',
  $xdebug_max_nesting_level               = '1000',
  $session_gc_maxlifetime                 = '86400',

# Mysql Settings
  $mysql_root_password                    = 'rootpassword',
  $mysql_manage_config_file               = true,
  $mysql_key_buffer_size                  = 64M,
  $mysql_query_cache_limit                = 2M,
  $mysql_query_cache_size                 = 64M,
  $mysql_innodb_buffer_pool_size          = 512M,
  $mysql_innodb_additional_mem_pool_size  = 512M,
  $mysql_innodb_log_buffer_size           = 256M,
  $mysql_max_connections                  = 500,
  $mysql_max_heap_table_size              = 512M,
  $mysql_lower_case_table_names           = undef,  # nog een probleem
  $mysql_innodb_file_per_table            = '1',
  $mysql_tmp_table_size                   = 512M,
  $mysql_table_open_cache                 = 450,
  $mysql_sql_mode                         = 'TRADITIONAL',
  $mysql_long_query_time                  = 5,
  $mysql_slow_query_log                   = 1,
  $mysql_slow_query_log_file              = '/var/log/mysql/mysql-slow.log',
  $mysql_log                              = '/var/log/mysql/mysql.log',
  $mysql_character_set_server             = 'utf8',
  $mysql_collation_server                 = 'utf8_general_ci',
  $mysql_connect_timeout                  = undef,
  $mssql_connect_timeout                  = undef,
  $mssql_timeout                          = undef,

# Apache Settings
  $instances                              =
        {'ac.catalogueoflife.org' => {
          'serveraliases'   => '*.catalogueoflife.org',
          'docroot'         => '/var/www/htdocs',
          'directories'     => [{ 'path' => '/var/www/htdocs', 'options' => '-Indexes +FollowSymLinks +MultiViews', 'allow_override' => 'All' }],
          'port'            => 80,
          'serveradmin'     => 'webmaster@naturalis.nl',
          'priority'        => 10,
          },
        },
  $keepalive                            = 'On',
  $max_keepalive_requests               = '100',
  $keepalive_timeout                    = '1500',
  $timeout                              = '360000'
){

# install php modules
  php::module { [ 'gd','mysql','curl' ]: }

  php::ini { '/etc/php5/apache2/php.ini':
    memory_limit              => $php_memory_limit,
    upload_max_filesize       => $upload_max_filesize,
    post_max_size             => $post_max_size,
    max_execution_time        => $max_execution_time,
    max_input_vars            => $max_input_vars,
    max_input_time            => $max_input_time,
    session_gc_maxlifetime    => $session_gc_maxlifetime,
  }

# Install apache and enable modules
  class { 'apache':
    default_mods              => true,
    mpm_module                => 'prefork',
    keepalive                 => $keepalive,
    max_keepalive_requests    => $max_keepalive_requests,
    keepalive_timeout         => $keepalive_timeout,
  }

  include apache::mod::php
  include apache::mod::rewrite
  include apache::mod::speling

# Create instances (vhosts)
  class { 'role_col::instances':
      instances               => $instances,
  }

# Configure MySQL Security and finetuning if needed
  if $enable_mysql {
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
            'sql_mode'                        => $mysql_sql_mode,
            'long_query_time'                 => $mysql_long_query_time,
            'slow_query_log'                  => $mysql_slow_query_log,
      'slow_query_log_file'             => $mysql_slow_query_log_file,
      'log'                             => $mysql_log,
      'character_set_server'            => $mysql_character_set_server,
            'collation_server'                => $mysql_collation_server,
            'connect_timeout'                 => $mysql_connect_timeout,
 #          'default_socket_timeout'          => $mysql_default_socket_timeout,
            'mssql_connect_timeout'           => $mssql_connect_timeout,
            'mssql_timeout'                   => $mssql_timeout,
          }
        }
    }
  }

# General repo settings
  class { 'role_col::repogeneral': }

# Check out repositories
  create_resources('role_col::repo', $gitrepos)

# install extra packages
  package { $extra_packages:
    ensure => installed,
  }

# Make sure everything is running
  service { $services:
    ensure => "running",
  }
}
