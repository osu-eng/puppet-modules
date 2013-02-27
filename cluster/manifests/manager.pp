class cluster::manager {
  include cluster

  package { 'luci':
    ensure  => present,
    require => Yumrepo['rhel-ha'],
  }

  service { 'luci':
    ensure     => running,
    enable     => true,
    require    => Package['luci'],
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-cluster-manager':
      weight => '620',
      rule   => '-A INPUT -p tcp -m state --state NEW -m multiport --dports 8084 -j ACCEPT',
    }
  }
}
