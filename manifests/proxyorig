# == Class: role_reverseproxy
#
# Full description of class role_reverseproxy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'role_reverseproxy':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class role_reverseproxy {

  class {'nginx':}


  #### OPENSTACK
  nginx::resource::vhost { 'openstack.naturalis.nl': proxy => 'http://openstack_naturalis_nl', }
  nginx::resource::upstream { 'openstack_naturalis_nl': members => [' 10.61.2.89:80'], }

  #### CATALOGUE OF LIFE

  nginx::resource::upstream {'134_213_57_40':  members => ['134.213.57.40:80'], }
  nginx::resource::upstream {'46_149_28_153':  members => ['46.149.28.153:80'], }
  nginx::resource::upstream {'46_149_20_81' :  members => ['46.149.20.81:80'], }
  nginx::resource::upstream {'162_13_189_143' :  members => ['162.13.189.143:80'], }

  nginx::resource::vhost {'www.catalogueoflife.* catalogueoflife.*': proxy    => 'http://134_213_57_40', }
  nginx::resource::vhost {'webservice.catalogueoflife.*' : proxy =>'http://46_149_20_81' }

  nginx::resource::location{ '162_13_189_143_testcol':
    location => '/testcol',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://162_13_189_143/testcol'
  }

  nginx::resource::location{ '162_13_189_143_piping':
    location => '/piping',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://162_13_189_143/piping'
  }

  nginx::resource::location{ '162_13_189_143_tree_estiamtes':
    location => '/tree_estimates',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://162_13_189_143/tree_estimates'
  }

  nginx::resource::location{ '46_149_20_81_DCA_Export':
    location => '/DCA_Export',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_20_81/DCA_Export'
  }

  nginx::resource::location{ '46_149_20_81_listmatching':
    location => '/listmatching',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_20_81/listmatching'
  }

  nginx::resource::location{ '46_149_20_81_webservices':
    location => '/webservices',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_20_81/webservices'
  }

  nginx::resource::location{ '46_149_20_81_col':
    location => '/col',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_20_81/col'
  }

  nginx::resource::location{ '46_149_20_81_colwebsite':
    location => '/colwebsite',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://134_213_57_40'
  }

  nginx::resource::location{ '46_149_20_81_dynamic-checklist':
    location => '/dynamic-checklist',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_20_81/dynamic-checklist'
  }

  nginx::resource::location{ '46_149_28_153_annual-checklist':
    location => '/annual-checklist',
    vhost    => 'www.catalogueoflife.* catalogueoflife.*',
    proxy    => 'http://46_149_28_153/annual-checklist'
  }

  nginx::resource::location{ 'webservices_46_149_28_153_annual-checklist':
    location => '/annual-checklist',
    vhost    => 'webservice.catalogueoflife.*',
    proxy    => 'http://46_149_28_153/annual-checklist'
  }

  nginx::resource::location{ 'webservices_46_149_20_81_col':
    location => '/col',
    vhost    => 'webservice.catalogueoflife.*',
    proxy    => 'http://46_149_20_81/col'
  }

  nginx::resource::location{ 'webservices_46_149_20_81_webservices':
    location => '/webservices',
    vhost    => 'webservice.catalogueoflife.*',
    proxy    => 'http://46_149_20_81/webservices'
  }


  #### OPENUP
  nginx::resource::vhost { 'openup.naturalis.nl': proxy => 'http://openup_naturalis_nl', }
  nginx::resource::upstream { 'openup_naturalis_nl': members => [' 10.21.1.103:80'], }

  #### MEDIALIB
  nginx::resource::vhost { 'medialib.naturalis.nl': proxy => 'http://medialib_naturalis_nl', }
  nginx::resource::upstream { 'medialib_naturalis_nl': members => [' 10.61.2.56:80'], }

  #### MEDIALIB OAI-PMH
  nginx::resource::vhost { 'webservices.naturalis.nl': proxy    => 'http://webservices_medialib_oai-pmh', }
  nginx::resource::upstream { 'webservices_medialib_oai-pmh': members => ['10.61.2.58:80',], }

  nginx::resource::location{ 'medialib_oaipmh':
    location => 'webservices.naturalis.nl/medialib/oai-pmh',
    vhost    => 'webservices.naturalis.nl',
    proxy    => 'http://webservices_medialib_oai-pmh/medialib/oai-pmh'
  }

  #### TOPDESK
  nginx::resource::vhost { 'ictsupport.naturalis.nl servicedesk.naturalis.nl': proxy => 'http://topdesk', }
  nginx::resource::upstream { 'topdesk': members => [' 10.21.1.142:80'], }

  ### ETIVM1
  nginx::resource::upstream { 'etivm1_naturalis_nl': members => [' 10.21.1.149:80'], }
  nginx::resource::vhost { 'etivm1.naturalis.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'appdata.naturalis.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'determineren.nederlandsesoorten.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'determinatie.nederlandsesoorten.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'identify.naturalis.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'widget.nederlandsesoorten.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'nlbif.etibioinformatics.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'nlbif.eti.uva.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.eti.uva.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'eti.uva.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.uitgestorvenvogels.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'uitgestorvenvogels.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'etibioinformatics.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.etibioinformatics.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.bio-wie.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.ugabif.go.ug': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'ugabif.go.ug': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'aries.etibioinformatics.nl': proxy => 'http://etivm1_naturalis_nl',}
  nginx::resource::vhost { 'walvisstrandingen.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.walvisstrandingen.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'natuurwidget.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'www.natuurwidget.nl': proxy => 'http://etivm1_naturalis_nl', }
  nginx::resource::vhost { 'seedlists.naturalis.nl': proxy => 'http://etivm1_naturalis_nl', }

  ### ETIVM2
  nginx::resource::upstream { 'etivm2_naturalis_nl': members => [' 10.21.1.150:80'], }
  nginx::resource::vhost { 'etivm2.naturalis.nl': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'bioportaal.nl': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'www.bioportaal.nl': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'wbd.etibioinformatics.nl': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'species-identification.eu': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'www.species-identification.eu': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'species-identification.org': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'www.species-identification.org': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'soortenbank.nl': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'www.soortenbank.nl': proxy => 'http://etivm2_naturalis_nl', }
  nginx::resource::vhost { 'prod.etibioinformatics.nl': proxy => 'http://etivm2_naturalis_nl', }

  ### TEST MEDIALIB
  nginx::resource::upstream { 'testmedialib_naturalis_nl': members => [' 10.21.1.153:80'], }
  nginx::resource::vhost { 'testmedialib.naturalis.nl': proxy => 'http://testmedialib_naturalis_nl', }
  nginx::resource::vhost { 'testwebservices.naturalis.nl': proxy => 'http://testmedialib_naturalis_nl', }


  ### DIERENDETERMINATIE #### WERKT NIET
  # nginx::resource::upstream { 'dierendeterminatie_cloud_naturalis_nl': members => ['10.40.1.26:80']}
  # nginx::resource::vhost { 'dierendeterminatie.cloud.naturalis.nl': proxy => 'http://dierendeterminatie_cloud_naturalis_nl', }


  ### SP2000
  nginx::resource::upstream { '46_149_29_20': members => [' 46.149.29.20:80'], }
  nginx::resource::vhost { 'www.sp2000.* sp2000.* ': proxy => 'http://46_149_29_20', }
  nginx::resource::vhost { 'www.sp2000europa.* sp2000europa.* ': proxy => 'http://46_149_29_20', }
  nginx::resource::vhost { 'www.species2000.* species2000.* ': proxy => 'http://46_149_29_20', }
  nginx::resource::vhost { 'documents.species2000.*': proxy => 'http://46_149_29_20', }
  nginx::resource::vhost { 'documents.sp2000.*': proxy => 'http://46_149_29_20', }

  ### NEDERLANDSESOORTEN
  nginx::resource::upstream { '162_13_138_110': members => ['162.13.138.110:80'], }
  #nginx::resource::upstream { '162_13_138_109': members => ['162.13.138.109:80'], }
  nginx::resource::upstream { '134_213_166_80': members => ['134.213.166.80:80'], }

  nginx::resource::vhost { 'nederlandsesoorten.nl www.nederlandsesoorten.nl soortenregister.nl www.soortenregister.nl': proxy => 'http://162_13_138_110', }

  nginx::resource::location{ '134_213_166_80_linneaus_ng':
    location => '/linnaeus_ng',
    vhost    => 'nederlandsesoorten.nl www.nederlandsesoorten.nl soortenregister.nl www.soortenregister.nl',
    #proxy    => 'http://162_13_138_109/linnaeus_ng'
    proxy    => 'http://134_213_166_80/linnaeus_ng'
  }


  ### API BIODIVERSITYDATA
  nginx::resource::upstream { '10_42_1_192': members => ['10.42.1.192:80'], }
  nginx::resource::vhost { 'api.biodiversitydata.nl': proxy => 'http://10_42_1_192', }
  nginx::resource::vhost { 'data.biodiversitydata.nl': proxy => 'http://10_42_1_192', }






}
