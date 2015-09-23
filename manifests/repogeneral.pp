# == Class: role_col::repogeneral
#
# === Authors
#
# Author Name <hugo.vanduijn@naturalis.nl>
#
#
class role_col::repogeneral ()
{

# ensure git package for repo checkouts
  package { 'git':
    ensure => installed,
  }

# copy known_hosts.sh file from puppet module
  file { '/usr/local/sbin/known_hosts.sh' :
    ensure    => present,
    mode      => '0750',
    group     => 'git',
    source    => 'puppet:///modules/role_col/known_hosts.sh'
  }

# create group git
  group { 'git':
    ensure    => present
  }

# create /opt/git
  file { '/opt/git':
    ensure      => directory,
    mode        => '0775',
    group       => 'git',
    require     => Group['git']
  }

}


