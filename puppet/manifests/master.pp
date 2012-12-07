class puppet::master {
  Class['puppet'] -> Class['puppet::master']

  package { 'puppet-server':
    ensure => present,
  }

  service { 'puppet-server':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['puppet-server'],
    subscribe  => File['/etc/puppet/puppet.conf'],
  }
}
