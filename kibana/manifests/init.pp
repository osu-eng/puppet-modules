class kibana (

) {

  archive { 'kibana-3.1.0':
    ensure => present,
    url    => 'https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz',
    target => '/var/www/kibana',
    checksum => false
  } 

  file { '/var/www/kibana/config.js':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/kibana/config.js',
  }

  file { '/etc/httpd/conf.d/kibana.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/kibana/httpd.conf',
  }
}
