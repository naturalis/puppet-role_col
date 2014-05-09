# == Class: role_col::workbench
#
#

class role_col::workbenchdb(
  $databases            = ['Assembly_Asteroidea',
                          'Assembly_Base_Schema',
                          'Assembly_Bochusacea',
                          'Assembly_Brachiopoda',
                          'Assembly_Brachypoda',
                          'Assembly_Brachyura',
                          'Assembly_Bryozoa',
                          'Assembly_Chaetognatha',
                          'Assembly_Cumacea',
                          'Assembly_Echinoidea',
                          'Assembly_Ferns',
                          'Assembly_Gastrotricha',
                          'Assembly_Global',
                          'Assembly_Global_Deploy',
                          'Assembly_Global_Deploy_Previous',
                          'Assembly_Global_Deploy_Previous_bak30oct2013',
                          'Assembly_Global_Deploy_bak30oct2013',
                          'Assembly_Global_bak30oct2013',
                          'Assembly_Gnathostomulida',
                          'Assembly_Holothuroidea',
                          'Assembly_Hydrozoa',
                          'Assembly_ITIS',
                          'Assembly_Isopoda',
                          'Assembly_Leptostraca',
                          'Assembly_Mystacocarida',
                          'Assembly_Nemertea',
                          'Assembly_Oligochaeta',
                          'Assembly_Ophiuroidea',
                          'Assembly_Phoronida',
                          'Assembly_Placozoa',
                          'Assembly_Polychaeta',
                          'Assembly_Polycystina',
                          'Assembly_Porifera',
                          'Assembly_Priapulida',
                          'Assembly_Remipedia',
                          'Assembly_Scaphopoda',
                          'Assembly_TIGR_Reptiles',
                          'Assembly_Tanaidacea',
                          'Assembly_Tantulocarida',
                          'Assembly_Thermosbaenacea',
                          'Assembly_World_Plants',
                          'Assembly_World_Plants2',
                          'Assembly_World_Plants_Old',
                          'Assembly_Xenoturbellida',
                          'Buffer_Asteroidea',
                          'Buffer_Bochusacea',
                          'Buffer_Brachiopoda',
                          'Buffer_Brachypoda',
                          'Buffer_Brachyura',
                          'Buffer_Bryozoa',
                          'Buffer_Chaetognatha',
                          'Buffer_Cumacea',
                          'Buffer_Echinoidea',
                          'Buffer_Ferns',
                          'Buffer_Gastrotricha',
                          'Buffer_Gnathostomulida',
                          'Buffer_Holothuroidea',
                          'Buffer_Hydrozoa',
                          'Buffer_ITIS',
                          'Buffer_Isopoda',
                          'Buffer_Leptostraca',
                          'Buffer_Mystacocarida',
                          'Buffer_Nemertea',
                          'Buffer_Oligochaeta',
                          'Buffer_Ophiuroidea',
                          'Buffer_Phoronida',
                          'Buffer_Placozoa',
                          'Buffer_Polychaeta',
                          'Buffer_Polycystina',
                          'Buffer_Porifera',
                          'Buffer_Priapulida',
                          'Buffer_Remipedia',
                          'Buffer_Scaphopoda',
                          'Buffer_TIGR_Reptiles',
                          'Buffer_Tanaidacea',
                          'Buffer_Tantulocarida',
                          'Buffer_Thermosbaenacea',
                          'Buffer_World_Plants',
                          'Buffer_World_Plants2',
                          'Buffer_World_Plants_Old',
                          'Buffer_Xenoturbellida',
                          'CoLTTC',
                          'CoLTTC_bak17oct2013',
                          'TaylorAndFrancis',
                          'ac2014',
                          'mysql',
                          'phpharvester',
                          'piping_devel',
                          'piping_new'],
)
{

  class { 'mysql::bindings':
    php_enable      => true
  }

  class { 'mysql::server':
    root_password       => $role_col::workbench::mysqlRootPassword,
  }
 
#  mysql::db { $databases:
#    user            => $role_col::workbench::mysqlUser,
#    password        => $role_col::workbench::mysqlPassword,
#    host            => 'localhost',
#    grant           => ['ALL'],
#  }


}
