class mail {
  package { [ 'mailx', 'mailcap', 'sendmail', 'procmail' ]:
    ensure => present,
  }

  package { [ 'exim', 'postfix' ]:
    ensure => absent
  }

  service { 'sendmail':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['sendmail'],
  }
}
