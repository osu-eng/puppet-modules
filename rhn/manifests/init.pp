class rhn(
  $activation_key = $rhn::params::activation_key
) inherits rhn::params {

  if ! $activation_key {
    fail('No RHN activation key was specified')
  }

  file { '/usr/share/rhn':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/rhn/RHN-ORG-TRUSTED-SSL-CERT',
    require => File['/usr/share/rhn'],
  }

  class { 'rhn_register':
    activationkey => $activation_key,
    require => File['/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT'],
  }
}
