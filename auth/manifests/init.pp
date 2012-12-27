class auth(
  $base = $auth::params::base,
  $uri = $auth::params::uri,
  $schema = $auth::params::schema,
  $root_dn = $auth::params::root_dn,
  $realm = $auth::params::realm,
  $kdc = $auth::params::kdc,
  $ticket_lifetime = $auth::params::ticket_lifetime,
  $login_groups = $auth::params::login_groups,
  $admin_group = $auth::params::admin_group
) inherits auth::params {

  include auth::config
  include sudo

  package { [
    'openldap',
    'openldap-clients',
    'sssd',
    'pam_krb5',
    'krb5-workstation'
  ]:
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

  if $admin_group {
    sudo::directive {'admin_group':
      ensure  => present,
      content => "%${admin_group} ALL=(ALL)       ALL",
    }
  }
}
