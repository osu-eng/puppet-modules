class apache::mod::dev {
  include apache

  package { 'httpd-devel':
    ensure  => present,
    require => Package['httpd'],
  }
}
