class piranha(
  $repo_url = $piranha::params::repo_url
) inherits piranha::params {
  $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-rhel-local-lb'

  include apache

  yumrepo { 'rhel-lb':
    descr    => 'Hat Enterprise Linux Load Balancer',
    baseurl  => "${repo_url}/LoadBalancer",
    gpgkey   => "file:///${gpgkey}",
    enabled  => 1,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }

  file { $gpgkey:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/piranha/RPM-GPG-KEY-rhel-local-lb',
  }

  package {[ 'piranha', 'ipvsadm' ]:
    ensure  => present,
    require => Yumrepo['rhel-lb'],
  }

  service { 'piranha-gui':
    ensure     => running,
    enable     => true,
    require    => Package['piranha'],
  }
  service { 'pulse':
    ensure     => running,
    enable     => true,
    require    => Package['piranha'],
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-piranha-gui':
      weight => '320',
      rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 3636 -j ACCEPT',
    }
  }
}
