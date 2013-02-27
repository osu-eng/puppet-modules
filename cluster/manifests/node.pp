class cluster::node(
  $ricci_password = $cluster::params::ricci_password
) inherits cluster::params {

  include cluster

  package {[ 'ccs', 'cman', 'omping', 'rgmanager', 'ricci' ]:
    ensure  => present,
    require => Yumrepo['rhel-ha'],
  }

  service { 'ricci':
    ensure     => running,
    enable     => true,
    require    => Package['ricci'],
  }

  user { 'ricci':
    ensure   => present,
    gid      => 'ricci',
    shell    => '/sbin/nologin',
    home     => '/var/lib/ricci',
    password => $ricci_password,
    require  => Package['ricci'],
    notify   => Service['ricci'],
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-cluster-management-udp':
      weight => '625',
      rule   => '-A INPUT -p udp -m state --state NEW -m multiport --dports 5404,5405 -j ACCEPT',
    }
    firewall::rule { 'allow-cluster-management-tcp':
      weight => '626',
      rule   => '-A INPUT -p tcp -m state --state NEW -m multiport --dports 11111,16851,21064 -j ACCEPT',
    }
  }

  file { '/usr/share/selinux/targeted/fenced.pp':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    source  => 'puppet:///modules/cluster/fenced.pp',
  }

  selmodule { 'fenced':
    ensure      => present,
    syncversion => true,
    require     => File['/usr/share/selinux/targeted/fenced.pp'],
  }
}
