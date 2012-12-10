class motd(
     $message = $motd::params::message
    ) inherits motd::params {

  file { '/etc/motd':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('motd/motd.erb'),
  }
}
