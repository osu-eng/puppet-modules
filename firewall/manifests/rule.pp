define firewall::rule (
  $rule,
  $weight = '500',
  $fragment_dir = '/etc/firewall.d'
) {

  include firewall

  file { "${fragment_dir}/fragments/${weight}${title}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "${rule}\n",
    notify  => Exec['firewall-concat'],
    before  => File['/etc/sysconfig/iptables'],
  }
}
