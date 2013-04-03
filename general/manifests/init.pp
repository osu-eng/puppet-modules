class general {
  $package_list = [
    'man',
    'wget',
    'gcc',
    'make',
    'vim-enhanced',
    'git',
    'patch',
  ]
  $package_blacklist = []

  package { $package_list:
    ensure => present
  }
  package { $package_blacklist:
    ensure => absent
  }
}
