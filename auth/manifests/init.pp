class auth(
  $base = $auth::params::base,
  $uri = $auth::params::uri,
  $schema = $auth::params::schema
) inherits auth::params {

  include auth::config

  package { [ 'openldap', 'openldap-clients', 'sssd' ]:
    ensure => present,
  }

  service { 'sssd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['sssd'],
    subscribe  => File['/etc/sssd/sssd.conf'],
  }
}
