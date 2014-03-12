# == Class: role_col::workbench
#
#

class role_solr::workbench(
  $services			= ['mysqld','httpd','webmin']
)
{
  service { $services:
    ensure => "running",
  }
}
