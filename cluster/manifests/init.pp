class cluster(
  $repo_url = $cluster::params::repo_url
) inherits cluster::params {
  $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-rhel-local'

  yumrepo { 'rhel-ha':
    descr    => 'Hat Enterprise Linux High Availability',
    baseurl  => "${repo_url}/HighAvailability",
    gpgkey   => "file:///${gpgkey}",
    enabled  => 1,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }
  yumrepo { 'rhel-rs':
    descr    => 'Hat Enterprise Linux Resilient Storage',
    baseurl  => "${repo_url}/ResilientStorage",
    gpgkey   => "file:///${gpgkey}",
    enabled  => 1,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }
  yumrepo { 'rhel-lb':
    descr    => 'Hat Enterprise Linux Load Balancer',
    baseurl  => "${repo_url}/LoadBalancer",
    gpgkey   => "file:///${gpgkey}",
    enabled  => 1,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }

  file { $gpgkey:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/cluster/RPM-GPG-KEY-rhel-local',
  }
}
