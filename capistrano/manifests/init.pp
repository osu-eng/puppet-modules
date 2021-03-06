class capistrano(
  $deploy_keys = $capistrano::params::deploy_keys,
  $deploy_to = $capistrano::params::deploy_to
) inherits capistrano::params {

  package {[ 'capistrano', 'bundler', 'rvm-capistrano' ]:
    ensure   => present,
    provider => gem,
  }

  group { 'deployer':
    ensure => present,
    system => true,
  }

  user { 'deployer':
    ensure     => present,
    gid        => 'deployer',
    shell      => '/bin/bash',
    home       => '/home/deployer',
    managehome => true,
    system     => true,
    require    => Group['deployer'],
  }

  sudo::directive { 'capistrano_deployer':
    ensure  => present,
    content => "deployer ALL=(ALL) NOPASSWD: /usr/sbin/useradd",
  }

  file { '/home/deployer/.ssh':
    ensure  => directory,
    owner   => 'deployer',
    group   => 'deployer',
    mode    => '0700',
    require => User['deployer'],
  }

  file { '/home/deployer/.ssh/authorized_keys':
    ensure  => present,
    owner   => 'deployer',
    group   => 'deployer',
    mode    => '0600',
    require => File['/home/deployer/.ssh'],
    content => template('capistrano/authorized_keys.erb'),
  }

  file { $deploy_to:
    ensure  => directory,
    owner   => 'deployer',
    group   => 'deployer',
    require => User['deployer'],
  }
}
