# == Class: role_col::dynamicchecklist
#
#

class role_col::dynamicchecklist(
  $services			= ['mysqld','httpd']
)
{
  service { $services:
    ensure => "running",
  }
}
