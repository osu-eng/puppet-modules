class shibboleth_server::params {
  $entity = 'http://web.engineering.osu.edu/production'
  
  $session_lifetime = 28800
  $session_timeout = 3600 
  $session_relay_state = 'ss:mem'
  $session_check_address = 'false'  # TRUE makes hijacking much harder but blocks access via proxy 
  $session_handler_ssl = 'true' 
  $session_cookie_props = 'https'
  
  $support_contact = 'eng-web@osu.edu'
  
  
  # $ip_hash = hiera('network_settings::site', false)
  #
  # Allow access to every host defined in network settings
  # $listener_acl = '' 
  #
  # Listen only on the address for this hosts FQDN
  # if $ip_hash[$fqdn]['ip'] {
  #   $listener_address = $ip_hash[$fqdn]['ip']
  # }
  # else {
  #   $listener_address = ''
  # }
  # $listener_port = '1600'
  
  
  # CHANGE THIS
  $key_source = '/etc/puppet/private/etc/shibboleth/sp-key.pem'
  $cert_source = '/etc/puppet/private/etc/shibboleth/sp-cert.pem'
}
