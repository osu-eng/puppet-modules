class general {
  $package_list = [ 'man', 'wget', 'gcc', 'make', 'vim-enhanced' ]
  $package_blacklist = []

  include mail

  package { $package_list:
    ensure => present
  }
  package { $package_blacklist:
    ensure => absent
  }
}
