class log_client {

  file { "/var/log/logstash-forwarder":
    ensure => "directory"
  }

  class { 'logstashforwarder':
    manage_repo  => true,
    servers  => [ 'logstash.web.engineering.osu.edu:4545' ],
    ssl_key  => '/etc/httpd/conf/private.key',
    ssl_ca   => '/etc/httpd/conf/ca-chain.cert',
    ssl_cert => '/etc/httpd/conf/public.cert',
    init_template => 'logstashforwarder/etc/init.d/logstashforwarder.RedHat.erb'
  }

  logstashforwarder::file { 'messages':
    paths  => [ '/var/log/messages', '/var/log/secure' ],
    fields => { 'type' => 'syslog' }
  }

}
