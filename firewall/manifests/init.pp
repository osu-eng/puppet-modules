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
    recurse => true,
    source  => 'puppet:///modules/firewall/fragment_dir',
  }

  file { "${fragment_dir}/filter":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    recurse => true,
    purge   => true,
    notify  => Exec['firewall-concat'],
  }

  file { "${fragment_dir}/mangle":
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
    source  => 'puppet:///modules/firewall/fragment_dir/concat.sh',
  }
}
