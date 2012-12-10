class ntp(
     $is_virtual = $ntp::params::is_virtual,
     $servers = $ntp::params::servers
    ) inherits ntp::params {

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
      hasstatus  => true,
      require    => Package['ntp'],
      subscribe  => File['/etc/ntp.conf'],
    }
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
