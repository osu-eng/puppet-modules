class ssh(
     $port = $ssh::params::port
    ) inherits ssh::params {

  package { 'openssh':
    ensure => present,
  }

  service { 'sshd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['openssh'],
    subscribe  => File['/etc/ssh/sshd_config'],
  }

  file { '/etc/ssh/sshd_config':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Package['openssh'],
    content => template('ssh/sshd_config.erb'),
  }

  file { '/etc/ssh/banner':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['openssh'],
    source  => 'puppet:///modules/ssh/banner',
  }
}
