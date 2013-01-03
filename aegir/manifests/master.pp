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
  
) inherits aegir::params {
 
  include aegir
  
  
}
