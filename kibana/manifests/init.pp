class kibana (

) {

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
