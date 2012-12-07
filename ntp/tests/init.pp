class { 'ntp':
  is_virtual => true,
  servers    => [ '0.pool.ntp.org', '1.pool.ntp.org' ]
}
