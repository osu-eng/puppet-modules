class ruby::dev {
  include ruby

  package { 'ruby-devel':
    ensure => present,
  }
}
