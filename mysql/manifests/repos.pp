class mysql::repos {
  yumrepo { 'mariadb':
    descr    => 'Shibboleth (OpenSuse Security) - $basearch',
    baseurl  => 'http://yum.mariadb.org/5.5/rhel6-amd64/',
    gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
    enabled  => 1,
    gpgcheck => 1,
  }
}

