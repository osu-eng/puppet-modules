class general {
  $package_list = [
    'man',
    'wget',
    'gcc',
    'make',
    'vim-enhanced',
    'git',
    'patch',
    'clamav',
  ]
  $package_blacklist = []

  package { $package_list:
    ensure => present
  }
  package { $package_blacklist:
    ensure => absent
  }

  file {'99-vmware-scsi-udev.rules':
    path    => '/etc/udev/rules.d/99-vmware-scsi-udev.rules',
    ensure  => present,
    source => 'puppet:///modules/general/99-vmware-scsi-udev.rules',
  }

  sysctl { 'kernel.hung_task_timeout_secs':
    value => '420',
  }

}
