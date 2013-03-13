class inetd {
  package { 'xinetd':
    ensure => present
  }
}
