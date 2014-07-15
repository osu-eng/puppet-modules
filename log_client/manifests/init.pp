class log_client {

  file { '/etc/logstashforwarder/ssl/public.cert':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///private/etc/httpd/conf/public.cert',
  } 

  file { '/etc/logstashforwarder/ssl/ca-chain.cert':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///private/etc/httpd/conf/ca-chain.cert',
  } 

  file { '/etc/logstashforwarder/ssl/private.key':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///private/etc/httpd/conf/private.key',
  }

  file { "/var/log/logstash-forwarder":
    ensure => "directory"
  }

  class { 'logstashforwarder':
    manage_repo  => true,
    servers  => [ 'logstash.web.engineering.osu.edu:4545' ],
    ssl_key  => '/etc/logstashforwarder/ssl/private.key',
    ssl_ca   => '/etc/logstashforwarder/ssl/ca-chain.cert',
    ssl_cert => '/etc/logstashforwarder/ssl/public.cert',
    init_template => 'logstashforwarder/etc/init.d/logstashforwarder.RedHat.erb'
  }

  logstashforwarder::file { 'messages':
    paths  => [ '/var/log/messages', '/var/log/secure' ],
    fields => { 'type' => 'syslog' }
  }

}
