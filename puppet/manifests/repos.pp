class puppet::repos {
  $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'

  yumrepo { 'puppetlabs-products':
    descr    => 'Puppet Labs Products El 6 - $basearch',
    baseurl  => 'http://yum.puppetlabs.com/el/6/products/$basearch',
    gpgkey   => "file:///${gpgkey}",
    enabled  => 1,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }

  yumrepo { 'puppetlabs-deps':
    descr    => 'Puppet Labs Dependencies El 6 - $basearch',
    baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
    gpgkey   => "file:///${gpgkey}",
    enabled  => 1,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }

  yumrepo { 'puppetlabs-devel':
    descr    => 'Puppet Labs Devel El 6 - $basearch',
    baseurl  => 'http://yum.puppetlabs.com/el/6/devel/$basearch',
    gpgkey   => "file:///${gpgkey}",
    enabled  => 0,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }

  yumrepo { 'puppetlabs-products-source':
    descr          => 'Puppet Labs Products El 6 - $basearch - Source',
    baseurl        => 'http://yum.puppetlabs.com/el/6/products/SRPMS',
    gpgkey         => "file:///${gpgkey}",
    failovermethod => priority,
    enabled        => 0,
    gpgcheck       => 1,
    require        => File[$gpgkey],
  }

  yumrepo { 'puppetlabs-deps-source':
    descr    => 'Puppet Labs Source Dependencies El 6 - $basearch - Source',
    baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/SRPMS',
    gpgkey   => "file:///${gpgkey}",
    enabled  => 0,
    gpgcheck => 1,
    require  => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'],
  }

  yumrepo { 'puppetlabs-devel-source':
    descr    => 'Puppet Labs Devel El 6 - $basearch - Source',
    baseurl  => 'http://yum.puppetlabs.com/el/6/devel/SRPMS',
    gpgkey   => "file:///${gpgkey}",
    enabled  => 0,
    gpgcheck => 1,
    require  => File[$gpgkey],
  }

  file { $gpgkey:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/puppet/RPM-GPG-KEY-puppetlabs',
  }
}
