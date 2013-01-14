class mysql::server (


) inherits mysql::params {

  include mysql

  package { [ 'mysql-server' ]:
    ensure => present,
  }
  
  file { '/etc/my.cnf':
    ensure  => present,
    owner   => 'root', 
    group   => 'root',
    mode    => '0644',
    require => Package['mysql-server'],
    content => template('mysql/my.cnf.erb'),
  }
  
  if defined('firewall') {
    firewall { '725 allow mysql internally':
      proto  => 'tcp',
      dport  => 3306,
      source => '164.107.58.0/24',
      action => 'accept',
    }
  }
  
  file { '/root/puppet-mysql-readme.txt':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['mysql-server'],
    content => template('mysql/readme.txt.erb'),
  }
}