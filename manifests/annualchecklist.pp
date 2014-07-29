# == Class: role_col::annualchecklist
#
#

class role_col::annualchecklist(
  $services         = ['mysqld','httpd','sshd']
)
{
  service { $services:
    ensure => "running",
  }
}
