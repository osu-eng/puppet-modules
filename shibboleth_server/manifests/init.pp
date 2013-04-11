class shibboleth_server (
  $entity = $shibboleth_server::params::entity,
  $session_lifetime = $shibboleth_server::params::session_lifetime,
  $session_timeout = $shibboleth_server::params::session_timeout,
  $session_relay_state = $shibboleth_server::params::session_relay_state,
  $session_check_address = hiera('shibboleth_server::session_check_address', $shibboleth_server::params::session_check_address),
  $session_handler_ssl = hiera('shibboleth_server::session_handler_ssl', $shibboleth_server::params::session_handler_ssl),
  $session_cookie_props = $shibboleth_server::params::session_cookie_props,
  $support_contact = $shibboleth_server::params::support_contact,
  $key_source = $shibboleth_server::params::key_source,
  $cert_source = $shibboleth_server::params::cert_source,
) inherits shibboleth_server::params {

  # Important Files
  $shibboleth2      = '/etc/shibboleth/shibboleth2.xml'
  $attribute_map    = '/etc/shibboleth/attribute-map.xml'
  $attribute_policy = '/etc/shibboleth/OSU-attribute-policy.xml'
  $metadata         = '/etc/shibboleth/OSU-metadata.pem'
  $session_error    = '/etc/shibboleth/sessionError.html'
  $key              = '/etc/shibboleth/sp-key.pem'
  $cert             = '/etc/shibboleth/sp-cert.pem'

  # Include Repo and Packages
  include shibboleth_server::repos
  package { 'shibboleth':
    ensure => present,
  }

  # Enable Service
  service { 'shibd':
    ensure     => 'running',
    enable     => true,
    require    => Package['shibboleth'],
    subscribe  => File[$shibboleth2, $attribute_map, $attribute_policy, $metadata, $session_error, $key, $cert],
  }

  # Various configuration files
  file { $shibboleth2:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('shibboleth_server/shibboleth2.xml.erb'),
  }
  file { $attribute_map:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/shibboleth_server/attribute-map.xml',
  }
  file { $attribute_policy:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/shibboleth_server/OSU-attribute-policy.xml',
  }
  file { $metadata:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/shibboleth_server/OSU-metadata.pem',
  }
  file { $session_error:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('shibboleth_server/sessionError.html.erb'),
  }
  file { $key:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $key_source,
  }
  file { $cert:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $cert_source,
  }
}
