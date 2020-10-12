# CoL Loadbalancer / reverse proxy
#
#
#
#
#
class role_col::lb (
  $server       = { 'col_server'      => {  'proxy' => 'http://colwww',
                                            'server_name' => ['www.catalogueoflife.* catalogueoflife.*'],
                                            'server_cfg_append' => 'limit_req zone=one',
                                            'ssl'          => true,
                                            'ssl_cert'     => '/etc/ssl/www_catalogueoflife_org.crt',
                                            'ssl_key'      => '/etc/ssl/www_catalogueoflife_org.key',
                                         },
                    'col_ws_server'   => {  'proxy' => 'http://coldc',
                                            'server_name' => ['webservice.catalogueoflife.*'],
                                            'ssl'          => true,
                                            'ssl_cert'     => '/etc/ssl/webservice_catalogueoflife_org.crt',
                                            'ssl_key'      => '/etc/ssl/webservice_catalogueoflife_org.key',
                                         },
                },
  $location    = {'loc_ac'          => {  'location' => '/annual-checklist',
                                          'server' => 'col_server',
                                          'proxy' => 'http://colac/annual-checklist'},
                  'loc_dc'          => {  'location' => '/dynamic-checklist',
                                          'server' => 'col_server',
                                          'proxy' => 'http://coldc/dynamic-checklist'},
                  'loc_col'         => {  'location' => '/col',
                                          'server' => 'col_server',
                                          'proxy' => 'http://coldc/col'},
                  'loc_DCA_Export'  => {  'location' => '/DCA_Export',
                                          'server' => 'col_server',
                                          'proxy' => 'http://coldc/DCA_Export'},
                  'loc_listmatching' => {  'location' => '/listmatching',
                                          'server' => 'col_server',
                                          'proxy' => 'http://coldc/listmatching'},
                  'loc_webservices' => {  'location' => '/webservices',
                                          'server' => 'col_server',
                                          'proxy' => 'http://coldc/webservices'},
                  'loc_colwebsite'  => {  'location' => '/colwebsite',
                                          'server' => 'col_server',
                                          'proxy' => 'http://colwww/colwebsite'},
                  'loc_ws_ac'       => {  'location' => '/annual-checklist',
                                          'server' => 'col_ws_server',
                                          'proxy' => 'http://colac/annual-checklist'},
                  'loc_ws_col'      => {  'location' => '/col',
                                          'server' => 'col_ws_server',
                                          'proxy' => 'http://coldc/col'},
                  'loc_ws_ws '      => {  'location' => '/webservices',
                                          'server' => 'col_ws_server',
                                          'proxy' => 'http://coldc/webservices'},
                  'loc_testcol'     => {  'location' => '/testcol',
                                          'server' => 'col_server',
                                          'proxy' => 'http://colwb/testcol'},
                  'loc_tree_estimates' => {  'location' => '/tree_estimates',
                                          'server' => 'col_server',
                                          'proxy' => 'http://colwb/tree_estimates'},
                  'loc_piping'      => {  'location' => '/piping',
                                          'server' => 'col_server',
                                          'proxy' => 'http://colwb/piping'}

                 },
  $upstream    = { 'colac' => {
                                'members' => ['162.13.1.86'],
                               },
                   'coldc' => {
                                'members' => ['162.13.2.44'],
                               },
                   'colwww' => {
                                'members' => ['145.136.242.11'],
                               },
                   'colwb' => {
                                'members' => ['162.13.189.143'],
                               }
                  },
#  $files       = {}
){

# copy ratelimit config part file from puppet module
  file{ '/etc/nginx/conf.d/ratelimit.conf' :
    ensure    => present,
    mode      => '0644',
    source    => 'puppet:///modules/role_col/ratelimit.conf',
  }

# copy filesizelimit config part file from puppet module
  file{ '/etc/nginx/conf.d/filesizelimit.conf' :
    ensure    => present,
    mode      => '0644',
    source    => 'puppet:///modules/role_col/filesizelimit.conf',
  }

  class { 'nginx':
    keepalive_timeout        => '600s',
    proxy_send_timeout       => '600s',
    proxy_read_timeout       => '600s',
  }

#  create_resources
  create_resources(nginx::resource::server,$server,{})
  create_resources(nginx::resource::location,$location,{})
  create_resources(nginx::resource::upstream,$upstream,{})
}

