class unitrends {
  # Installs dependencies for the Unitrends backup client.
  # Does not install the client itself.
  include inetd

  package {[
    'libattr.i686',
    'libcom_err.i686',
    'krb5-devel.i686',
    'keyutils-libs-devel.i686',
    'libxml2.i686',
    'zlib-devel.i686',
    'ncurses-devel.i686',
    ]:
    ensure => present
  }
}
