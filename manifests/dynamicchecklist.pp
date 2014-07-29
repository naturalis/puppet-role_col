# == Class: role_col::dynamicchecklist
#
#

class role_col::dynamicchecklist(
  $services             = ['mysqld','httpd','sshd'],
  $rwwebdirs            = ['/var/www/DCA_Export_v1.3/export','/var/www/DCA_Export_v1.3/zip','/var/www/DCA_Export_v1.3/zip-fixed'],
)
{
  service { $services:
    ensure => "running",
  }

  file { $rwwebdirs:
    ensure  => 'directory',
    mode    => '0644',
    owner   => 'apache',
    group   => 'apache',
    recurse     => true,
  }

}
