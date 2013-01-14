class php(
  $max_execution_time = $php::params::max_execution_time,
  $max_input_time = $php::params::max_input_time,
  $memory_limit = $php::params::memory_limit,
  $post_max_size = $php::params::post_max_size,
  $upload_max_filesize = $php::params::upload_max_filesize
) inherits php::params {

  package { 'php-cli':
    ensure => present,
  }

  file { '/etc/php.ini':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['php-cli'],
    notify  => Service['httpd'],
    content => template('php/apc.ini.erb'),
  }

  if defined( Service['httpd'] ) {
    File['/etc/php.ini'] {
      notify  => Service['httpd'],
    }
  }
}

