class ssh::known_hosts {
  $defaults = {
    ensure   => present,
    type     => ssh-rsa,
  }

  $site_known_hosts = hiera('ssh::site', false)
  if $site_known_hosts {
    create_resources(sshkey, $site_known_hosts)
  }
}
