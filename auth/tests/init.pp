class { 'auth':
  base            => 'dc=local',
  uri             => 'ldap://ldap.local',
  schema          => 'rfc2307',
  root_dn         => 'cn=admin,dc=local',
  realm           => 'EXAMPLE.COM',
  kdc             => 'kerberos.example.com:88',
  ticket_lifetime => '24h',
  login_groups    => [ 'wheel' ],
}
