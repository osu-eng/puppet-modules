class php::apache {
  include php
  include apache

  package {[
    'php',
    'php-process',
    'php-xml',
    'php-mysql',
    'php-ldap',
    'php-mbstring',
    'php-pdo'
  ]:
    ensure => present,
  }

  file { '/etc/httpd/conf.d/php.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['httpd'],
    source  => 'puppet:///modules/php/php.conf',
  }
}
