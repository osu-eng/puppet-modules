class auth::config {
  file { '/etc/nsswitch.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/nsswitch.conf',
  }

  file { '/etc/sysconfig/authconfig':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/sysconfig/authconfig',
  }

  file { '/etc/pam.d/system-auth':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/pam.d/system-auth',
  }

  file { '/etc/pam.d/password-auth':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/pam.d/password-auth',
  }

  file { '/etc/pam.d/smartcard-auth':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/pam.d/smartcard-auth',
  }

  file { '/etc/pam.d/fingerprint-auth':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/auth/etc/pam.d/fingerprint-auth',
  }

  file { '/etc/openldap/ldap.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['openldap'],
    content => template('auth/etc/openldap/ldap.conf.erb'),
  }

  file { '/etc/sssd/sssd.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Package['sssd'],
    content => template('auth/etc/sssd/sssd.conf.erb'),
  }
}