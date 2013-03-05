class { 'aegir::master':
  user_id           => 342,
  user_name         => 'aegir',
  group_id          => 342,
  group_name        => 'aegir',
  home              => '/var/aegir',
  apache_group_name => 'apache',
  dot_drush         => '/var/aegir/.drush',
}
