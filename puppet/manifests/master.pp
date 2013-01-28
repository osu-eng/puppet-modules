class puppet::master {
  package { 'puppet-server':
    ensure => present,
  }

  service { 'puppetmaster':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['puppet-server'],
    subscribe  => File['/etc/puppet/puppet.conf'],
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-puppet-master':
      weight => '655',
      rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 8140 -j ACCEPT',
    }
  }

  file { '/etc/puppet/hiera.yaml':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/hiera.yaml',
  }

  file { '/etc/puppet/fileserver.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/fileserver.conf',
  }

  file { '/etc/puppet/private':
    ensure  => directory,
    owner   => 'root',
    group   => 'puppet',
    mode    => '0750',
    require => Package['puppet-server'],
  }
}
