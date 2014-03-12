# == Class: role_col::annualchecklist
#
#

class role_solr::annualchecklist(
  $services			= ['mysqld','httpd']
)
{
  service { $services:
    ensure => "running",
  }
}
