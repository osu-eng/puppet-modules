class cron {
  package { [ 'cronie', 'cronie-anacron', 'crontabs' ]:
    ensure => present,
  }

  service { 'crond':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['cronie'],
  }
}
