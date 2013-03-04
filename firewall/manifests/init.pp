class firewall(
  $fragment_dir = $firewall::params::fragment_dir
) inherits firewall::params {

  package { 'iptables':
    ensure => present,
  }

  service { 'iptables':
    ensure     => running,
    enable     => true,
    require    => Package['iptables'],
  }

  exec { 'firewall-concat':
    command     => "${fragment_dir}/concat.sh ${fragment_dir}",
    refreshonly => true,
    before      => File['/etc/sysconfig/iptables'],
  }

  file { '/etc/sysconfig/iptables':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => [
      "${fragment_dir}/firewall-rules",
      'puppet:///modules/firewall/firewall-default'
    ],
    notify  => Service['iptables'],
  }

  file { $fragment_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  file { "${fragment_dir}/fragments":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    recurse => true,
    purge   => true,
    notify  => Exec['firewall-concat'],
  }

  file { "${fragment_dir}/concat.sh":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    source  => 'puppet:///modules/firewall/concat.sh',
  }

  file { "${fragment_dir}/firewall-pre":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/firewall/firewall-pre',
  }

  file { "${fragment_dir}/firewall-post":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/firewall/firewall-post',
  }
}
