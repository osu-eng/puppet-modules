class apache {
  package { 'httpd':
    ensure => present,
  }

  service { 'httpd':
    ensure     => running,
    enable     => true,
    require    => Package['httpd'],
    subscribe  => File['/etc/httpd/conf/http.conf'],
  }

  file { '/etc/httpd/conf/http.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
    content => template('apache/httpd.conf.erb'),
  }
}
