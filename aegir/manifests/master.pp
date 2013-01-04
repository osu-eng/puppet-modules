class aegir::master (
  
  # If you want to override users
  $user_id = $aegir::params::user_id,
  $user_name = $aegir::params::user_name,
  
  # If you want to override group
  $group_id = $aegir::params::group_id,
  $group_name = $aegir::params::group_name,
  
  # If you want to override home
  $home = $aegir::params::home,
  
  # Aegir keys
  $private_key_source = $aegir::params::private_key_source,
  $public_key_source = $aegir::params::public_key_source,
  $authorized_keys = $aegir::params::authorized_keys,
  
  # Apache options
  $apache_group_name = $aegir::params::apache_group_name,
  
  # Drush options
  $dot_drush = $aegir::params::dot_drush,
  
) inherits aegir::params {
 
  include aegir
  include pear
    
  # Note, pear module readme indicates this could fail without latest pear
  pear::package { "drush":
    version => "4.6.0",
    repository => "pear.drush.org",
    require    => Package['php-pear'],
  }
  
  # Download provision with drush 
  exec { 'provision_install':
    command    => "/usr/bin/drush dl --yes --destination=${dot_drush} provision-6.x",
    creates    => "${dot_drush}/provision",
  }
}
