class rubies(
  $versions = $rubies::params::versions,
  $rvm_users = $rubies::params::rvm_users
) inherits rubies::params {

  include rvm

  rubies::ruby { $versions: }
  rvm::system_user { $rvm_users: }
}
