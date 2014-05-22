define role_col::workbenchusers(
  $comment,
  $password = "tmppasswd123"
) {

  $shell    = '/bin/false'
  $groups   = 'gsd'
  $home     = "/home/GSDS/${title}"
  $username = $title
  $sha1passwd = sha1($password)
  user { $username:
    ensure      => present,
    groups      => $groups,
    shell       => $shell,
    comment     => $comment,
    home        => $home,
    require     => Group['gsd']
  }

  file { $home:
     ensure  => directory,
     owner   => $username,
     group   => 'gsd',
     mode    => '0755',
     require => [Group['gsd'],File['/home/GSDS']]
  }

  exec { "adduser_${username}":
    command     => "/bin/echo ${username}:x:0 >> /etc/webmin/miniserv.users",
    unless      => "/bin/grep -c ${username} /etc/webmin/miniserv.users"
  }->
  exec { "changepass_${username}":
    command    => "/usr/libexec/webmin/changepass.pl /etc/webmin ${username} ${password}",
    unless      => "/bin/grep -c ${username} /etc/webmin/miniserv.users"
  }
}
