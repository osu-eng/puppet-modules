class mail {
  package { [ 'mailx', 'mailcap', 'sendmail', 'procmail' ]:
    ensure => present,
  }

  service { 'sendmail':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['sendmail'],
  }
}
