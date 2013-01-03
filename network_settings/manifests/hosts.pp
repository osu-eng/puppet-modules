class network_settings::hosts {
  $site_hosts = hiera('nodes', false)
  if $site_hosts {
    create_resources(host, $site_hosts)
  }
}
