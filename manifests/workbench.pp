# == Class: role_col::workbench
#
#

class role_col::workbench(
  $services			= ['mysqld','httpd','webmin']
)
{
  service { $services:
    ensure => "running",
  }
}
