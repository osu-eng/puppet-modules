class auth(
  $base = $auth::params::base,
  $uri = $auth::params::uri,
  $schema = $auth::params::schema,
  $root_dn = $auth::params::root_dn,
  $realm = $auth::params::realm,
  $kdc = $auth::params::kdc,
  $ticket_lifetime = $auth::params::ticket_lifetime,
  $admin_group = $auth::params::admin_group,
  $net_user_group = $auth::params::net_user_group,
  $login_groups = hiera_array('auth::allowed_login_groups', $auth::params::login_groups)
) inherits auth::params {

  include auth::config
  include sudo

  package { [
    'openldap',
    'openldap-clients',
    'sssd',
    'pam_krb5',
    'krb5-workstation'
  ]:
    ensure => present,
  }

  service { 'sssd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['sssd'],
    subscribe  => File['/etc/sssd/sssd.conf'],
  }

  if $admin_group {
    sudo::directive {'admin_group':
      ensure  => present,
      content => "%${admin_group} ALL=(ALL)        ALL",
    }
    sudo::directive {'admin_group_sftp':
      ensure  => present,
      content => "%${admin_group} ALL=(ALL) NOPASSWD: /usr/libexec/openssh/sftp-server",
    }
  }
}
