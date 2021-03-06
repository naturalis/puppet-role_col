# == Class: role_col::dynamicupdate
#
#

class role_col::dynamicupdate(
  $workspace_dir                        = $role_col::conf::workspace_dir,
  $update_hour                          = $role_col::conf::update_hour,
  $download_ip                          = $role_col::conf::download_ip,
  $download_user                        = $role_col::conf::download_user,
  $download_pass                        = $role_col::conf::download_password,
  $mysql_user                           = 'root',
  $mysql_password                       = $role_col::conf::mysql_root_password,
  $dcupdate_password                    = $role_col::conf::dcupdate_password
){

# create workspace dir
  file { $workspace_dir:
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0700'
  }

# create log dir
  file { "/var/log/col":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0700'
  }

# create logrotate
  file { '/etc/logrotate.d/colupdate':
    ensure  => present,
    mode    => '0644',
    content => template('role_col/logrotate_colupdate.erb'),
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

# Create db_stats.php file used for comparing imported DB to exported DB 
  file { "${workspace_dir}/db_stats.php":
    ensure      => present,
    content     =>  template('role_col/db_stats.php.erb'),
    owner       => 'root',
    group       => 'root',
    mode        => '0700',
    require     => File[$workspace_dir]
  }

# Add sudoers lines
  $sudoers_array = ["Cmnd_Alias CHKUPDATE = /usr/local/sbin/checkupdate.sh",
                    "sensu ALL = (root) NOPASSWD : CHKUPDATE"]

  $sudoers_array.each |String $sudoers_line| {
    file_line {$sudoers_line:
      path   => '/etc/sudoers',
      line   => $sudoers_line
    }
  }

# Create checkupdate.sh file used for sensu monitoring
  file { '/usr/local/sbin/checkupdate.sh':
    ensure      => present,
    content     =>  template('role_col/checkupdate.erb'),
    mode        => '0700',
    require     => File[$workspace_dir]
  }

# export check so sensu monitoring can make use of it
  @sensu::check { 'Check update' :
    command => 'sudo /usr/local/sbin/checkupdate.sh',
    tag     => 'central_sensu',
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

# Create dcaupdate.sh file
  file { "${workspace_dir}/dcaupdate.sh":
    ensure      => present,
    content     =>  template('role_col/dcaupdate.erb'),
    owner       => 'root',
    group       => 'root',
    mode        => '0700',
    require     => File[$workspace_dir]
  }


# Set cronjob
cron { colupdate:
  command => "${workspace_dir}/colupdate.sh >> /var/log/col/colupdate.log",
  user    => root,
  hour    => $update_hour,
  minute  => 0
}

# Set cronjob for dca 12 hours after colupdate
cron { dcaupdate:
  command => "${workspace_dir}/dcaupdate.sh >> /var/log/col/colupdate.log",
  user    => root,
  hour    => $dcaupdate_hour,
  minute  => 0
}



}