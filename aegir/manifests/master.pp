class aegir::master (
  # If you want to override users
  $user_id = $aegir::params::user_id,
  $user_name = $aegir::params::user_name,

  # If you want to override group
  $group_id = $aegir::params::group_id,
  $group_name = $aegir::params::group_name,

  # If you want to override home
  $home = $aegir::params::home,

  # Apache options
  $apache_group_name = $aegir::params::apache_group_name,

  # Drush options
  $dot_drush = $aegir::params::dot_drush
) inherits aegir::params {

  include aegir
  include pear

  # Note, pear module readme indicates this could fail without latest pear
  pear::package { 'Console_Table':
    version    => '1.1.3',
    require    => Package['php-pear'],
  }
  pear::package { 'drush':
    version    => '5.9.0',
    repository => 'pear.drush.org',
    require    => Pear::Package['Console_Table']
  }

  # Download provision with drush 
  exec { 'provision_install':
    command => "/usr/bin/sudo -uaegir /usr/bin/drush dl --yes --destination=${dot_drush} provision-2.0-rc5",
    creates => "${dot_drush}/provision",
  }

  file { "${home}/.ssh/id_rsa":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => '0600',
    source  => "puppet:///private${home}/.ssh/id_rsa",
    require => File["$home/.ssh"]
  }

  file { "${home}/.ssh/id_rsa.pub":
    ensure  => present,
    owner   => $user_name,
    group   => $group_name,
    mode    => '0644',
    source  => "puppet:///private${home}/.ssh/id_rsa.pub",
    require => File["$home/.ssh"]
  }
}
