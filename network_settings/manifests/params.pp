class network_settings::params {
  $interface = 'eth0'
  $dns       = [ '8.8.8.8', '8.8.4.4' ]
  $domain    = 'local'
  $search    = 'local'
  $netmask   = '255.255.255.0'
  $gateway   = '192.168.1.1'
  $state     = 'up'

  $ip_hash = hiera('network_settings::site', false)
  if $ip_hash[$fqdn]['ip'] {
    $ip = $ip_hash[$fqdn]['ip']
  }
}
