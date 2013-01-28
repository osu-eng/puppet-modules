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
  
  if defined('firewall::rule') {
    firewall::rule { 'allow-mysql-internally':
      weight => '725',
      rule   => '-A INPUT -s 164.107.58.0/24 -p tcp -m multiport --dports 3306 -j ACCEPT',
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