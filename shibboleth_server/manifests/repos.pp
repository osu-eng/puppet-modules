class shibboleth_server::repos {

  yumrepo { 'security_shibboleth':
    descr    => 'Shibboleth (OpenSuse Security) - $basearch',
    baseurl  => 'http://download.opensuse.org/repositories/security:/shibboleth/RHEL_6/',
    gpgkey   => 'http://download.opensuse.org/repositories/security:/shibboleth/RHEL_6/repodata/repomd.xml.key',
    enabled  => 1,
    gpgcheck => 1,
  }
}
