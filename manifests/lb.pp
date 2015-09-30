# CoL Loadbalancer / reverse proxy
#
#
#
#
#
class role_col::lb (
  $vhost       = { 'col_vhost'      => { 'proxy' => 'http://colwww',
                                         'server_name' => ['www.catalogueoflife.* catalogueoflife.*'] },
                   'col_ws_vhost'   => { 'proxy' => 'http://coldc',
                                         'server_name' => ['webservice.catalogueoflife.*'] }
                },
  $location    = {'loc_ac'          => {  'location' => '/annual-checklist',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://colac/annual-checklist'},
                  'loc_dc'          => {  'location' => '/dynamic-checklist',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://coldc/dynamic-checklist'},
                  'loc_col'         => {  'location' => '/col',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://coldc/col'},
                  'loc_DCA_Export'  => {  'location' => '/DCA_Export',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://coldc/DCA_Export'},
                  'loc_listmatching' => {  'location' => '/listmatching',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://coldc/listmatching'},
                  'loc_webservices' => {  'location' => '/webservices',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://coldc/webservices'},
                  'loc_colwebsite'  => {  'location' => '/colwebsite',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://colwww/colwebsite'},
                  'loc_ws_ac'       => {  'location' => '/annual-checklist',
                                          'vhost' => 'col_ws_vhost',
                                          'proxy' => 'http://colac/annual-checklist'},
                  'loc_ws_col'      => {  'location' => '/col',
                                          'vhost' => 'col_ws_vhost',
                                          'proxy' => 'http://coldc/col'},
                  'loc_ws_ws '      => {  'location' => '/webservices',
                                          'vhost' => 'col_ws_vhost',
                                          'proxy' => 'http://coldc/webservices'},
                  'loc_testcol'     => {  'location' => '/testcol',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://colwb/testcol'},
                  'loc_tree_estimates' => {  'location' => '/tree_estimates',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://colwb/tree_estimates'},
                  'loc_piping'      => {  'location' => '/piping',
                                          'vhost' => 'col_vhost',
                                          'proxy' => 'http://colwb/piping'}

                 },
  $upstream    = { 'colac' => {
                                'members' => ['162.13.1.86'],
                               },
                   'coldc' => {
                                'members' => ['162.13.2.44'],
                               },
                   'colwww' => {
                                'members' => ['134.213.57.40'],
                               },
                   'colwb' => {
                                'members' => ['162.13.189.143'],
                               }
                  },
#  $files       = {}
){

  class { 'nginx': }

#  create_resources(nba::lb::wwwfiles,$files,{})
  create_resources(nginx::resource::vhost,$vhost,{})
  create_resources(nginx::resource::location,$location,{})
  create_resources(nginx::resource::upstream,$upstream,{})
}
