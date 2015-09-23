# == Define: role_col::repo
#
# === Authors
#
# Author Name <hugo.vanduijn@naturalis.nl>
#
#
define role_col::repo (
  $repouser         = $title,
  $repolocation     = '/opt/git',
  $reporevision     = 'master',
  $repoversion      = 'present',
  $reposource,
  $repokey,
)
{

# set local variable for template sshconfig.erb
$repokeyname = $repouser

# create user
  user { $repouser :
    ensure      => present,
    groups      => 'git',
    home        => "/home/${repouser}",
    require     => Class['role_col::repogeneral']
  }

# create homedirectory
  file { "/home/${repouser}":
    ensure      => 'directory',
    owner       => $repouser,
    mode        => '0770',
    require     => User[$repouser]
  }

# Create .ssh directory
  file { "/home/${repouser}/.ssh":
    ensure    => directory,
    owner     => $repouser,
  }->
# Create .ssh/repokey file
  file { "/home/${repouser}/.ssh/${repouser}":
    ensure    => present,
    content   => $repokey,
    owner     => $repouser,
    mode      => '0600',
  }->
# Create sshconfig file
  file { "/home/${repouser}/.ssh/config":
    ensure    => present,
    content   =>  template('role_col/sshconfig.erb'),
    owner     => $repouser,
    mode      => '0600',
  }->
# run known_hosts.sh for future acceptance of github key
  exec{ 'add_known_hosts' :
    command   => '/usr/local/sbin/known_hosts.sh',
    cwd       => "/home/${repouser}/.ssh/",
    path      => '/sbin:/usr/bin:/usr/local/bin/:/bin/',
    provider  => shell,
    user      => $repouser,
    unless    => "test -f /home/${repouser}/.ssh/known_hosts",
    require   => Class['role_col::repogeneral']
  }->
# give known_hosts file the correct permissions
  file{ "/home/${repouser}/.ssh/known_hosts":
    mode      => '0600',
    owner     => $repouser
  }->
# checkout using vcsrepo
  vcsrepo { "${repolocation}/${repouser}":
    ensure    => $repoversion,
    provider  => 'git',
    source    => $reposource,
    user      => $repouser,
    revision  => $reporevision,
  }
}
