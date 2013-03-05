class shibboleth_server::params {
  $entity = 'http://example.com/production'
  $session_lifetime = 28800
  $session_timeout = 3600 
  $session_relay_state = 'ss:mem'
  $session_check_address = false  # TRUE makes hijacking much harder but blocks access via proxy 
  $session_handler_ssl = true 
  $session_cookie_props = 'https'
  $support_contact = 'admin@example.com'
  $key_source = 'puppet:///private/etc/shibboleth/sp-key.pem'
  $cert_source = 'puppet:///private/etc/shibboleth/sp-cert.pem'
}
