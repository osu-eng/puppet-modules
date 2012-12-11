class { 'ntp':
  is_vm   => false,
  servers => [ '0.pool.ntp.org', '1.pool.ntp.org' ],
}
