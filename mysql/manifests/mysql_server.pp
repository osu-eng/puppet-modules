class mysql_server (


) inherits mysql_server::params {
 
  include mysql
  
  package { [ 'mysql-server' ]:
    ensure => present,
  }  
  
  file { '/etc/my.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['mysql-server'],
    content => template('mysql/my.cnf.erb'),
  }
}
