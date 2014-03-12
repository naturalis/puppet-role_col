# == Class: role_col::websites
#
#

class role_solr::websites(
  $services			= ['mysqld','httpd']
)
{
  service { $services:
    ensure => "running",
  }
}
