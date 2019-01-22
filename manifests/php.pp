# Install webserver and app
class role_col::php (
) {

  class { '::php::globals':
    php_version => '7.1',
    config_root => '/etc/php/7.1',
  }->
  class { '::php':
    manage_repos => true,
    settings     => {
      'PHP/max_execution_time'  => $role_col::max_execution_time,
      'PHP/max_input_time'      => $role_col::max_input_time,
      'PHP/memory_limit'        => $role_col::php_memory_limit,
      'PHP/post_max_size'       => $role_col::post_max_size,
      'PHP/upload_max_filesize' => $role_col::upload_max_filesize,
    },
    extensions => {
       'gd' => {},
       'curl' => {
         ini_prefix => '20-',
       },
       'apcu'  => {
         provider => 'pecl',
         settings => {
           'apc/stat'       => '1',
           'apc/stat_ctime' => '1',
         },
       },
       'json' => {},
       'readline' => {},
       'zip' => {},
       'mysql' => {
         'so_name' => 'mysqli'
       },
       'mbstring' => {},
    }
  }
}