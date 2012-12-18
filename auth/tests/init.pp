class { 'auth':
  base   => 'dc=local',
  uri    => 'ldap://ldap.local',
  schema => 'rfc2307',
}
