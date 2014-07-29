# == Class: role_col::websites
#
#

class role_col::websites(
  $services         = ['mysqld','httpd','sshd']
)
{
  service { $services:
    ensure => "running",
  }
}
