class log_client::web inherits log_client {

  logstashforwarder::file { 'apache-error':
    paths  => [ '/var/log/httpd/error_log', '/var/log/httpd/ssl_error_log'],
    fields => { 'type' => 'apache-error' }
  }
}
