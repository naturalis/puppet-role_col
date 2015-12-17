# == Class: role_col::dynamicupdate
#
#

class role_col::dynamicupdate(
  $workspace_dir                        = $role_col::dynamicchecklist::workspace_dir,
  $update_hour                          = $role_col::dynamicchecklist::update_hour,
  $download_ip                          = $role_col::dynamicchecklist::download_ip,
  $download_user                        = $role_col::dynamicchecklist::download_user,
  $download_pass                        = $role_col::dynamicchecklist::download_pass,
  $mysql_user                           = 'root',
  $mysql_password                       = $role_col::dynamicchecklist::mysql_root_password,
  $dcupdate_password                    = $role_col::dynamicchecklist::dcupdate_password
){

#  create workspace dir
  file { $workspace_dir:
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0700'
  }


# Create colupdate.sh file
  file { "${workspace_dir}/colupdate.sh":
    ensure      => present,
    content     =>  template('role_col/colupdate.erb'),
    owner       => 'root',
    group       => 'root',
    mode        => '0700',
    require     => File[$workspace_dir]
  }

# Create colupdatelive.sh file
  file { "${workspace_dir}/colupdatelive.sh":
    ensure      => present,
    content     =>  template('role_col/colupdatelive.erb'),
    owner       => 'root',
    group       => 'root',
    mode        => '0700',
    require     => File[$workspace_dir]
  }
  
# Set cronjob
cron { colupdate:
  command => "${workspace_dir}/colupdate.sh >> ${workspace_dir}/update.log",
  user    => root,
  hour    => $update_hour,
  minute  => 0
}

}