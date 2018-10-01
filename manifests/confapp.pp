# == Define: role_col::confapp
#
# === Authors
#
# Author Name <hugo.vanduijn@naturalis.nl>
#
#
define role_col::confapp (
  $appfolder          ,
  $docroot            = '/var/www/htdocs',
)
{



#  docroot/appfolder
  file { "${docroot}/${appfolder}/":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0755',
    require     => File['approot'],
  }

#  docroot/appfolder/application
  file { "${docroot}/${appfolder}/application":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0755',
    require     => File["$docroot/${appfolder}"],
  }

#  docroot/appfolder/application/log
  file { "${docroot}/${appfolder}/application/log":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'www-data',
    mode        => '0775',
    recurse     => true,
    require     => File["$docroot/${appfolder}/application"],
  }

#  docroot/appfolder/application/cache
  file { "${docroot}/${appfolder}/application/cache":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'www-data',
    mode        => '0775',
    require     => File["$docroot/${appfolder}/application"],
  }

#  docroot/appfolder/public
  file { "${docroot}/${appfolder}/public":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0755',
    require     => File["$docroot/${appfolder}"],
  }


# Create .htaccess file
  file { "${docroot}/${appfolder}/public/.htaccess": 
    ensure      => present,
    content     => template('role_col/app.htaccess.erb'),
    owner       => $root,
    group       => 'www-data',
    mode        => '0640',
    require     => File["$docroot/${appfolder}/public"],
  }

# remove toplevel .htaccess
  file { "${docroot}/${appfolder}/.htaccess":
    ensure      => 'absent',
    require     => File["$docroot/${appfolder}"],
  }


}
