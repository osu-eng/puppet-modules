class piranha(
  $repo_url = $piranha::params::repo_url,
  $virtual_ip = $piranha::params::virtual_ip,
  $gui_password = $piranha::params::gui_password
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
    subscribe  => File['/etc/sysconfig/ha/conf/piranha.passwd'],
  }
  service { 'pulse':
    ensure     => running,
    enable     => true,
    require    => Package['piranha'],
  }

  file { '/etc/sysconfig/ha/conf/piranha.passwd':
    ensure  => present,
    owner   => 'piranha',
    group   => 'piranha',
    mode    => '0600',
    require => Package['piranha'],
    content => template('piranha/piranha.passwd.erb'),
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-piranha-gui':
      weight => '320',
      rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 3636 -j ACCEPT',
    }
    define piranha::markvip {
      firewall::rule { "bundle-http-https-${title}":
        weight => '110',
        table  => 'mangle',
        rule   => "-A PREROUTING -p tcp -d ${title}/32 -m multiport --dports 80,443 -j MARK --set-mark 80",
      }
    }
    piranha::markvip { $virtual_ip: }
  }
}
