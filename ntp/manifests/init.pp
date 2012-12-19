class ntp(
  $servers = $ntp::params::servers
) inherits ntp::params {

  package { 'ntp':
    ensure => present,
  }

  if $::is_virtual {
    $ensure = 'stopped'
    $enable = false
  } else {
    $ensure = 'running'
    $enable = true
  }
  service { 'ntpd':
    ensure     => $ensure,
    enable     => $enable,
    require    => Package['ntp'],
    subscribe  => File['/etc/ntp.conf'],
  }

  file { '/etc/ntp.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['ntp'],
    content => template('ntp/ntp.conf.erb'),
  }
}
