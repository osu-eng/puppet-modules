class kibana (

) {

  archive { 'kibana-3.1.0':
    ensure => present,
    url    => 'https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz',
    target => '/var/www',
    checksum => false
  }

  file { '/var/www/kibana':
    ensure => 'link',
    target => '/var/www/kibana-3.1.0',
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

  file { '/var/www/kibana/app/dashboards/ssh.json':
    source  => 'puppet:///modules/kibana/dashboards/ssh.json'
  }

  file { '/var/www/kibana/app/dashboards/apache-access.json':
    source  => 'puppet:///modules/kibana/dashboards/apache-access.json'
  }

  file { '/var/www/kibana/app/dashboards/drupal.json':
    source  => 'puppet:///modules/kibana/dashboards/drupal.json'
  }
}
