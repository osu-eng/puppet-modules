class resolv(
     $dns = $resolv::params::dns,
     $domain = $resolv::params::domain,
     $search = $resolv::params::search
    ) inherits resolv::params {

  file { '/etc/resolv.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('resolv/resolv.conf.erb'),
  }
}
