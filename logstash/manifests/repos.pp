class logstash::repos {
  yumrepo { 'epel':
    mirrorlist     => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-${::os_maj_version}&arch=${::architecture}",
    failovermethod => 'priority',
    enabled  => 1,
    gpgcheck => 0,
  }
}