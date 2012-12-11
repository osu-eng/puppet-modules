class network_settings(
  $interface = 'eth0',
  $dns       = [ '8.8.8.8', '8.8.4.4' ],
  $domain    = 'local',
  $search    = 'local',
  $address   = '192.168.1.2',
  $netmask   = '255.255.255.0',
  $gateway   = '192.168.1.1',
  $state     = 'up'
  ) {
  include network
  $macvar = "<%= scope.lookupvar('::macaddress_${interface}') %>"

  network::if::static { $interface:
    ipaddress  => $address,
    netmask    => $netmask,
    gateway    => $gateway,
    macaddress => inline_template($macvar),
    domain     => $domain,
    dns1       => $dns[0],
    dns2       => $dns[1],
    ensure     => $state,
  }

  file { '/etc/resolv.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('network_settings/resolv.conf.erb'),
  }
}
