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

  if defined('firewall') {
    firewall { '655 allow puppet master':
      proto  => 'tcp',
      dport  => '8140',
      action => 'accept',
    }
  }

  file { '/etc/puppet/hiera.yaml':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/hiera.yaml',
  }
}
