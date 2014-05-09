define role_col::workbenchusers(
  $comment,
  $username = $title,
  $shell    = '/bin/false',
  $groups   = 'gsd',
  $home     = "/home/GSDS/${title}"

) {
  user { $username:
    ensure      => present,
    uid         => $uid,
    gid         => $gid,
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

}
