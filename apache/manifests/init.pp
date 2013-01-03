class apache {
  package { [ 'httpd', 'mod_ssl' ]:
    ensure => present,
  }

  service { 'httpd':
    ensure     => running,
    enable     => true,
    require    => Package['httpd'],
    subscribe  => 
    subscribe => [
        File['/etc/httpd/conf/http.conf'],
        File['/etc/httpd/conf.d/ssl.conf']
    ],
  }

  file { '/etc/httpd/conf/http.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
    content => template('apache/httpd.conf.erb'),
  }

  file { '/etc/httpd/conf.d/ssl.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/apache/ssl.conf',
  }

  file { '/etc/httpd/conf/ca-chain.cert':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/apache/ca-chain.cert',
  }
}
