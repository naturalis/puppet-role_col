define role_col::workbenchdbperm(
  $user,
  $password,
  $privileges       = ['SELECT','INSERT','UPDATE','DELETE'],
) {

  $database = $title

  mysql_user { "${user}@127.0.0.1":
    ensure     => 'present',
    require    => Class['mysql::server']
  }

  mysql_database { $database:
    ensure     => 'present',
    require    => Class['mysql::server']
  }

  mysql_grant { "${user}@localhost/${database}.*":
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => $privileges,
    table      => '*.*',
    user       => "${user}@localhost",
  }

}
