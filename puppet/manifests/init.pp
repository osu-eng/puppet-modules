class puppet($server = 'puppet') {
  include puppet::repos

  package { 'puppet':
    ensure  => present,
    require => [
      Yumrepo['puppetlabs-products'],
      Yumrepo['puppetlabs-deps'],
      Yumrepo['puppetlabs-devel'],
      Yumrepo['puppetlabs-products-source'],
      Yumrepo['puppetlabs-deps-source'],
      Yumrepo['puppetlabs-devel-source'],
    ],
  }

  service { 'puppet':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['puppet'],
  }

  file { '/etc/puppet/puppet.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('puppet/puppet.conf.erb'),
    require => Package['puppet'],
    notify  => Service['puppet'],
  }

  file { '/etc/puppet/hiera.yaml':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/hiera.yaml',
  }
}
