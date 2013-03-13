class selinux(
  $status = $selinux::params::status,
  $type = $selinux::params::type
) inherits selinux::params {

  if ! ($status in ['enforcing', 'permissive', 'disabled']) {
    fail('SELinux status must be either enforcing, permissive, or disabled')
  }
  if ! ($type in ['targeted', 'mls']) {
    fail('SELinux type must be either targeted or enforcing')
  }

  package { ['selinux-policy', 'selinux-policy-targeted', 'policycoreutils-python']:
    ensure => present,
  }

  file { '/etc/selinux/config':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['selinux-policy', 'selinux-policy-targeted'],
    content => template('selinux/config.erb'),
    notify  => Exec['selinux-set-enforce'],
  }

  exec { 'selinux-set-enforce':
    command     => "/usr/sbin/setenforce ${status}",
    refreshonly => true,
  }
}
