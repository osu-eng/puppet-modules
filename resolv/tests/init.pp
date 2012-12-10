class { 'resolv':
  dns1   => [ '8.8.8.8', '8.8.4.4' ]
  domain => 'local',
  search => 'local',
}
