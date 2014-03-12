# == Class: role_col::annualchecklist
#
#

class role_col::annualchecklist(
  $services			= ['mysqld','httpd']
)
{
  service { $services:
    ensure => "running",
  }
}
