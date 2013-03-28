class capistrano(
  $deploy_keys = $capistrano::params::deploy_keys,
  $deploy_to = $capistrano::params::deploy_to
) inherits capistrano::params {

  include ruby

  user { 'deployer':
    ensure     => present,
    gid        => 'deployer',
    shell      => '/sbin/nologin',
    home       => '/home/deployer',
    managehome => true,
    system     => true,
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
