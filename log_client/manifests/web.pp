class log_client::web inherits log_client {

  logstashforwarder::file { 'apache-access':
    paths  => [ '/var/log/httpd/access_log' ],
    fields => { 'type' => 'apache-access' }
  }

  logstashforwarder::file { 'apache-access-ssl':
    paths  => [ '/var/log/httpd/ssl_access_log' ],
    fields => { 'type' => 'apache-access-ssl' }
  }

  logstashforwarder::file { 'apache-error':
    paths  => [ '/var/log/httpd/error_log', '/var/log/httpd/ssl_error_log'],
    fields => { 'type' => 'apache-error' }
  }	
}
