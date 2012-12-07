class ntp( $is_virtual = true ) {
  package { 'ntp':
    ensure => present,
  }

  if $is_virtual {
    service {'ntpd':
      ensure => stopped,
      enable => false,
    }
  }
  else {
    service { 'ntpd':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => Package['ntp'],
      subscribe  => File['/etc/ntp.conf'],
    }
  }

  file { '/etc/ntp.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    require => Package['ntp'],
    source  => 'puppet:///modules/ntp/ntp.conf',
  }
}