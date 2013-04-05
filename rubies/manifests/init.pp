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

  exec { 'rvm-selinux':
    command => '/root/rvm-selinux.sh > /root/rvm-selinux.output',
    require => [
      File['/root/rvm-selinux.sh'],
    ],
    creates => '/root/aegir-selinux.output',
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
