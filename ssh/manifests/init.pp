class ssh(
  $port = $ssh::params::port,
  $private_key = $ssh::params::private_key,
  $site = $ssh::params::site
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

  if defined('firewall::rule') {
    firewall::rule { 'allow-ssh':
      weight => '200',
      rule   => "-A INPUT -p tcp -m state --state NEW -m tcp --dport ${port} -j ACCEPT",
    }
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

  if $private_key {
    file { '/etc/ssh/ssh_host_rsa_key':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      require => Package['openssh'],
      source  => "puppet:///private/etc/ssh/ssh_host_rsa_key",
      notify  => Service['sshd'],
    }

    $public_key_type = $site[$::fqdn]['type']
    $public_key = $site[$::fqdn]['key']
    file { '/etc/ssh/ssh_host_rsa_key.pub':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['openssh'],
      content => template('ssh/ssh_host_rsa_key.pub.erb'),
      notify  => Service['sshd'],
    }
  }
}
