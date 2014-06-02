class auth::params {
  $base = 'dc=local'
  $uri = 'ldap://ldap.local'
  $schema = 'rfc2307'
  $ldap_ca_path = '/etc/pki/tls/certs'
  $ldap_cert_path = '/etc/pki/tls/certs/slapdcert.pem'
  $ldap_key_path = '/etc/pki/tls/private/slapdkey.pem'
  $root_dn = 'cn=admin,dc=local'
  $root_pw = ''
  $realm = 'EXAMPLE.COM'
  $kdc1 = 'krb1.it.ohio-state.edu'
  $kdc2 = 'krb2.it.ohio-state.edu'
  $ticket_lifetime = '600'
  $login_groups = [ 'wheel' ]
  $admin_group = false
  $net_user_group = 'NetUser'
}
