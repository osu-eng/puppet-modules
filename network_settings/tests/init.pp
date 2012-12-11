class { 'network_settings':
  interface => 'eth0',
  dns       => [ '8.8.8.8', '8.8.4.4' ],
  domain    => 'local',
  search    => 'local',
  address   => '192.168.1.2'
  netmask   => '255.255.255.0',
  gateway   => '192.168.1.1',
  state     => 'up',
}
