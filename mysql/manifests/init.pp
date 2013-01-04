class mysql {
  package { [ 'mysql' ]:
    ensure => present,
  }

  # Maybe something here about installing certificates for SSL?
  
}