class piranha::real_server(
  $virtual_ip = hiera('piranha::virtual_ip', $piranha::params::virtual_ip)
) inherits piranha::params {

  include network

  create_resources(piranha::add_vip, $virtual_ip)

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
