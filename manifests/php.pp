# Install webserver and app
class role_col::php (
) {

  $php_packages = [
    'php7.1-curl',
    'php7.1-apc',
    'php7.1-mysql',
  ]

  package { $php_packages:
    ensure  => present,
    require => Class['::php']
  }

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
  }

}