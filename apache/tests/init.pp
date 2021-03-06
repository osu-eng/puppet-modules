class { 'apache':
  timeout                => 120,
  keepalive              => true,
  max_keepalive_requests => 100,
  keepalive_timeout      => 7,
  start_servers          => 5,
  min_spare_servers      => 5,
  max_spare_servers      => 10,
  server_limit           => 256,
  max_requests_per_child => 4000,
  avg_child_memory       => 32,
  reserved_memory        => 256,
  log_exclude_ip         => [],
}
