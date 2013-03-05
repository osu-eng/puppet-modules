class piranha::real_server(
  $virtual_ip = hiera('piranha::virtual_ip', $piranha::params::virtual_ip)
) inherits piranha::params {

  include network

  define piranha::real_server::vip ($ip = $title, $netmask, $interface) {
    network::if::alias { $interface:
      ipaddress => $ip,
      netmask   => $netmask,
      ensure    => up,
    }
  }
  create_resources(piranha::real_server::vip, $virtual_ip)

  package { 'arptables_jf':
    ensure  => present,
  }

  service { 'arptables_jf':
    ensure     => running,
    enable     => true,
    require    => Package['arptables_jf'],
    subscribe  => File['/etc/sysconfig/arptables'],
  }

  file { '/etc/sysconfig/arptables':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => Package['arptables_jf'],
    content => template('piranha/arptables.erb'),
  }
}
