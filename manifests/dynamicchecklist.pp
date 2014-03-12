# == Class: role_col::dynamicchecklist
#
#

class role_solr::dynamicchecklist(
  $services			= ['mysqld','httpd']
)
{
  service { $services:
    ensure => "running",
  }
}
