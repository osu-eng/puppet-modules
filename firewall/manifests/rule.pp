define firewall::rule (
  $rule,
  $weight = $firewall::params::weight,
  $fragment_dir = $firewall::params::fragment_dir
) inherits firewall::params {

  include firewall

  file { "${fragment_dir}/fragments/${weight}${title}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => $rule,
    notify  => Exec['firewall-concat'],
    before  => File['/etc/sysconfig/iptables'],
  }
}
