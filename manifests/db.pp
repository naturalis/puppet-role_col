# == Class: role_col::annualchecklist
#
#

class role_col::db(
){

# Configure MySQL Security and finetuning if needed
  class { 'mysql::server::account_security':}
  class { 'mysql::server':
      root_password         => $role_col::conf::mysql_root_password,
      service_enabled       => true,
      service_manage        => true,
      manage_config_file    => $role_col::conf::mysql_manage_config_file,
      override_options      => {
        'mysqld'            => {
          'key_buffer_size'                 => $role_col::conf::mysql_key_buffer_size,
          'query_cache_limit'               => $role_col::conf::mysql_query_cache_limit,
          'query_cache_size'                => $role_col::conf::mysql_query_cache_size,
          'innodb_buffer_pool_size'         => $role_col::conf::mysql_innodb_buffer_pool_size,
#          'innodb_additional_mem_pool_size' => $role_col::conf::mysql_innodb_additional_mem_pool_size,
          'innodb_log_buffer_size'          => $role_col::conf::mysql_innodb_log_buffer_size,
          'max_connections'                 => $role_col::conf::mysql_max_connections,
          'max_heap_table_size'             => $role_col::conf::mysql_max_heap_table_size,
          'lower_case_table_names'          => $role_col::conf::mysql_lower_case_table_names,
          'innodb_file_per_table'           => $role_col::conf::mysql_innodb_file_per_table,
          'tmp_table_size'                  => $role_col::conf::mysql_tmp_table_size,
          'table_open_cache'                => $role_col::conf::mysql_table_open_cache,
#          'table_cache'                     => $role_col::conf::mysql_table_cache,
          'sql_mode'                        => $role_col::conf::mysql_sql_mode,
          'long_query_time'                 => $role_col::conf::mysql_long_query_time,
          'slow_query_log'                  => $role_col::conf::mysql_slow_query_log,
          'slow_query_log_file'             => $role_col::conf::mysql_slow_query_log_file,
          'character_set_server'            => $role_col::conf::mysql_character_set_server,
          'collation_server'                => $role_col::conf::mysql_collation_server,
          'connect_timeout'                 => $role_col::conf::mysql_connect_timeout,
          'thread_stack'                    => $role_col::conf::mysql_thread_stack,
          'thread_cache_size'               => $role_col::conf::mysql_thread_cachesize,
          'wait_timeout'                    => $role_col::conf::mysql_wait_timeout,
          'general_log'                     => $role_col::conf::mysql_general_log,
      }
    }
  }

}
