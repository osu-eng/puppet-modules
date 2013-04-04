class rubies(
  $versions = $rubies::params::versions,
  $rvm_users = $rubies::params::rvm_users
) inherits rubies::params {

  include rvm

  create_resources(rubies::ruby, $versions)
  create_resources(rvm::system_user, $rvm_users)
}
