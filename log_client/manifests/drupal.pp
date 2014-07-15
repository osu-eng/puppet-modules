class log_client::drupal inherits log_client{

  logstashforwarder::file { 'drupal':
    paths  => [ '/var/log/drupal.log' ],
    fields => { 'type' => 'drupal' }
  }
}
