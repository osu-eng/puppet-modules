class cluster::file_system {
  include cluster

  package {[ 'gfs2-utils', 'lvm2-cluster' ]:
    ensure  => present,
    require => Yumrepo['rhel-rs'],
  }
}
