class php::apc(
  $cache_memory = $php::params::cache_memory,
  $stat         = hiera('php::stat', $php::params::stat)
) inherits php::params {

  include php::apache

  if $stat {
    $apc_stat = 1
  } else {
    $apc_stat = 0
  }

  package { 'php-pecl-apc':
    ensure => present,
  }

  file { '/etc/php.d/apc.ini':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['php'],
    notify  => Service['httpd'],
    content => template('php/apc.ini.erb'),
  }
}