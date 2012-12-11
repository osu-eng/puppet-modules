class ntp($is_vm = false, $servers = [ '0.pool.ntp.org', '1.pool.ntp.org' ]) {
  package { 'ntp':
    ensure => present,
  }

  if $is_vm {
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
