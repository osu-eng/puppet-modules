class shibboleth_server::repos {

  $gpgkey = '/etc/pki/rpm-gpg/RPM-GPG-KEY-shibboleth'

  yumrepo { 'security_shibboleth':
    descr    => 'Shibboleth (OpenSuse Security) - $basearch',
    baseurl  => 'http://download.opensuse.org/repositories/security:/shibboleth/RHEL_6/$basearch',
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
    source  => 'puppet:///modules/shibboleth_server/RPM-GPG-KEY-shibboleth',
  }
}
