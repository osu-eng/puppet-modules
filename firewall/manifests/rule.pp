define firewall::rule (
  $rule,
  $weight = '500',
  $fragment_dir = '/etc/firewall.d',
  $table = 'filter'
) {

  if $table != 'filter' and $table != 'mangle' {
    fail("table must be one of filter or mangle")
  }

  include firewall

  $rule_name = regsubst($title, ' ', '-', 'G')

  file { "${fragment_dir}/${table}/${weight}${rule_name}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "${rule}\n",
    notify  => Exec['firewall-concat'],
    before  => File['/etc/sysconfig/iptables'],
    require => File["${fragment_dir}/${table}"],
  }
}
