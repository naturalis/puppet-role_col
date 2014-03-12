# == Class: role_col::websites
#
#

class role_col::websites(
  $services			= ['mysqld','httpd']
)
{
  service { $services:
    ensure => "running",
  }
}
