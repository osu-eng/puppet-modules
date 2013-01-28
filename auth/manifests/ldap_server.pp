class auth::ldap_server(
  $ldap_ca_path = $auth::params::ldap_ca_path,
  $ldap_cert_path = $auth::params::ldap_cert_path,
  $ldap_key_path = $auth::params::ldap_key_path,
  $base = $auth::params::base,
  $root_dn = $auth::params::root_dn,
  $root_pw = $auth::params::root_pw
) inherits auth::params {

  include auth

  package { 'openldap-servers':
    ensure => present,
  }

  service { 'slapd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['openldap-servers'],
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-ldap-server':
      weight => '225',
      rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 636 -j ACCEPT',
    }
  }

  file { '/etc/openldap/slapd.d':
    ensure  => directory,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0700',
    recurse => true,
    purge   => true,
    require => Package['openldap-servers'],
    source  => 'puppet:///modules/auth/etc/openldap/slapd.d',
  }

  file { '/etc/openldap/slapd.d/cn=config.ldif':
    ensure  => present,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0600',
    require => Package['openldap-servers'],
    notify  => Service['slapd'],
    content => template('auth/etc/openldap/slapd.d/cn=config.ldif.erb'),
  }

  file { '/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif':
    ensure  => present,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0600',
    require => Package['openldap-servers'],
    notify  => Service['slapd'],
    content => template('auth/etc/openldap/slapd.d/cn=config/olcDatabase={1}monitor.ldif.erb'),
  }

  file { '/etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif':
    ensure  => present,
    owner   => 'ldap',
    group   => 'ldap',
    mode    => '0600',
    require => Package['openldap-servers'],
    notify  => Service['slapd'],
    content => template('auth/etc/openldap/slapd.d/cn=config/olcDatabase={2}bdb.ldif.erb'),
  }

  file { '/etc/sysconfig/ldap':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/sysconfig/ldap',
  }

  file { $ldap_cert_path:
    ensure  => present,
    owner   => 'root',
    group   => 'ldap',
    mode    => '0644',
    require => Package['openldap-servers'],
    source  => "puppet:///private${ldap_cert_path}",
  }

  file { $ldap_key_path:
    ensure  => present,
    owner   => 'root',
    group   => 'ldap',
    mode    => '0750',
    require => Package['openldap-servers'],
    source  => "puppet:///private${ldap_key_path}",
  }
}