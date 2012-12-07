class base {
  $package_list = ['man', 'wget', 'gcc', 'make', 'vim-enhanced']
  $package_blacklist = []

  package { $package_list:
    ensure => present
  }
  package { $package_blacklist:
    ensure => absent
  }
}
