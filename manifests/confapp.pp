# == Define: role_col::confapp
#
# === Authors
#
# Author Name <hugo.vanduijn@naturalis.nl>
#
#
define role_col::confapp (
  $appfolder,
  $link = undef,
)
{

$rewritebase = $title

#  docroot/appfolder
  file { "${appfolder}/":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0755',
    require     => File['approot'],
  }

#  link if defined
  if $link {
    file { $link:
      ensure => 'link',
      target => $appfolder,
    }
  }

#  docroot/appfolder/application
  file { "${appfolder}/application":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0755',
    require     => File["${appfolder}"],
  }

#  docroot/appfolder/application/log
  file { "${appfolder}/application/log":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'www-data',
    mode        => '0775',
    recurse     => true,
    require     => File["${appfolder}/application"],
  }

#  docroot/appfolder/application/cache
  file { "${appfolder}/application/cache":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'www-data',
    mode        => '0775',
    require     => File["${appfolder}/application"],
  }

#  docroot/appfolder/public
  file { "${appfolder}/public":
    ensure      => 'directory',
    owner       => 'root',
    group       => 'root',
    mode        => '0755',
    require     => File["${appfolder}"],
  }


# Create .htaccess file
  file { "${appfolder}/public/.htaccess": 
    ensure      => present,
    content     => template('role_col/app.htaccess.erb'),
    owner       => $root,
    group       => 'www-data',
    mode        => '0640',
    require     => File["${appfolder}/public"],
  }

# remove toplevel .htaccess
  file { "${appfolder}/.htaccess":
    ensure      => 'absent',
    require     => File["${appfolder}"],
  }


}
