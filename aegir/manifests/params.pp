class aegir::params {
  
  # User info
  $user_id = 342
  $user_name = 'aegir'
  
  # If you want to override group
  $group_id = $user_id
  $group_name = $user_name
  
  # If you want to override home
  $home = "/var/$user_name"

  # SSH Keys
  $private_key_source = false
  $public_key_source = false
  $authorized_keys = false
  
  # Apache stuff
  $apache_group_name = 'apache'
  
  # Drush stiff
  $dot_drush = "${home}/.drush"
}
