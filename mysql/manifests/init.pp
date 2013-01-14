class mysql (


) inherits mysql::params {

  package { [ 'mysql' ]:
    ensure => present,
  }

}