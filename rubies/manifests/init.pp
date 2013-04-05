class rubies(
  $versions = $rubies::params::versions,
  $rvm_users = $rubies::params::rvm_users
) inherits rubies::params {

  include epel
  include rvm

  $packages = [ 'libyaml-devel', 'libffi-devel', 'libtool', 'bison' ]

  package { $packages:
    ensure => present,
  }

  rubies::ruby { $versions:
    require => Package[$packages],
  }

  rvm::system_user { $rvm_users:
    require => Package[$packages],
  }
}
