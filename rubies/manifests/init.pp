class rubies(
  $versions = $rubies::params::versions,
  $rvm_users = $rubies::params::rvm_users
) inherits rubies::params {

  include epel
  include rvm
  include selinux

  $packages = [ 'libyaml-devel', 'libffi-devel', 'libtool', 'bison' ]

  file { '/root/rvm-selinux.sh':
    source => 'puppet:///modules/rubies/rvm-selinux.sh',
    mode   => '0755',
  }

  selboolean { 'httpd_run_stickshift':
    persistent => true,
    value      => on,
  }

  file { '/usr/share/selinux/targeted/passenger.pp':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    source  => 'puppet:///modules/rubies/passenger.pp',
  }

  selmodule { 'passenger':
    ensure      => present,
    syncversion => true,
    require     => File['/usr/share/selinux/targeted/passenger.pp'],
  }

  exec { 'rvm-selinux':
    command => '/root/rvm-selinux.sh > /root/rvm-selinux.output',
    require => [
      File['/root/rvm-selinux.sh'],
    ],
    creates => '/root/rvm-selinux.output',
  }

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
