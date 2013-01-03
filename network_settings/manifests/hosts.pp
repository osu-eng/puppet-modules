class network_settings::hosts {
  $site_hosts = hiera('network_settings::hosts::site', false)
  if $site_hosts {
    create_resources(host, $site_hosts)
  }
}
