class services {
  if $::is_virtual {
    $ensure = 'stopped'
    $enable = false
  } else {
    $ensure = 'running'
    $enable = true
  }

  service { 'cpuspeed':
    ensure     => $ensure,
    enable     => $enable,
  }
  service { 'mdmonitor':
    ensure     => $ensure,
    enable     => $enable,
  }
  service { 'smartd':
    ensure     => $ensure,
    enable     => $enable,
  }
}
