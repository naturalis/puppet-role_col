# == Class: role_col::conf
#
#

class role_col::conf(
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
  $php_memory_limit                       = '512M',
  $upload_max_filesize                    = '16M',
  $post_max_size                          = '16M',
  $max_execution_time                     = '30',
  $max_input_time                         = '60',

# Mysql Settings
  $mysql_root_password                    = 'rootpassword',
  $mysql_manage_config_file               = true,
  $mysql_key_buffer_size                  = '1G',
  $mysql_max_allowed_package              = '16M',
  $mysql_thread_stack                     = '192K',
  $mysql_thread_cachesize                 = '8',
  $mysql_query_cache_limit                = '16M',
  $mysql_query_cache_size                 = '256M',
  $mysql_innodb_buffer_pool_size          = '512M',
  $mysql_innodb_additional_mem_pool_size  = '512M',
  $mysql_innodb_log_buffer_size           = '256M',
  $mysql_max_connections                  = '1024',
  $mysql_max_heap_table_size              = '128M',
  $mysql_lower_case_table_names           = '',  # nog een probleem
  $mysql_innodb_file_per_table            = '1',
  $mysql_tmp_table_size                   = '128M',
  $mysql_table_open_cache                 = '450',
  $mysql_table_cache                      = '128',
  $mysql_sql_mode                         = 'TRADITIONAL',
  $mysql_long_query_time                  = '5',
  $mysql_slow_query_log                   = '1',
  $mysql_slow_query_log_file              = '/var/log/mysql/mysql-slow.log',
  $mysql_general_log                      = 'off',
  $mysql_character_set_server             = 'utf8',
  $mysql_collation_server                 = 'utf8_general_ci',
  $mysql_connect_timeout                  = '3',
  $mysql_wait_timeout                     = '30',
  $keepalive                              = 'On',
  $max_keepalive_requests                 = '100',
  $keepalive_timeout                      = '1500',
  $timeout                                = '3600',

# Update Settings
  $workspace_dir                        = '/opt/colupdate',
  $download_ip                          = '162.1.1.1',
  $download_user                        = 'download',
  $download_password                    = 'downloadpass',
  $dcupdate_password                    = 'dcupdatapass',
  $update_hour                          = '14',
  $dcaupdate_hour                       = '02'

){
}
