class network_settings(
  $interface = $network_settings::params::interface,
  $dns       = $network_settings::params::dns,
  $domain    = $network_settings::params::domain,
  $search    = $network_settings::params::search,
  $netmask   = $network_settings::params::netmask,
  $gateway   = $network_settings::params::gateway,
  $state     = $network_settings::params::state,
  $use_ipv6  = hiera('network_settings::use_ipv6', $network_settings::params::use_ipv6),
  $ip        = $network_settings::params::ip
) inherits network_settings::params {

  include network
  $macvar = "<%= scope.lookupvar('::macaddress_${interface}') %>"

  if !$use_ipv6 {
    sysctl { 'net.ipv6.conf.all.disable_ipv6':
      value => '1',
    }
    sysctl { 'net.ipv6.conf.default.disable_ipv6':
      value => '1',
    }
  }

  network::if::static { $interface:
    ipaddress  => $ip,
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
