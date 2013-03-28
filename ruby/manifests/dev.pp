class ruby::dev {
  include ruby

  package {[
    'ruby-devel',
    'gcc-c++',
    'openssl-devel',
    'zlib-devel',
  ]:
    ensure => present,
  }
}
