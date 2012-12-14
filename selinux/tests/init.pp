class { 'selinux':
  status => 'enforcing',
  type   => 'targeted',
}
