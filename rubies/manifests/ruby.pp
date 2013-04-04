define rubies::ruby ($version = $title) {
  rvm_system_ruby { "ruby-${version}":
    ensure      => present,
    default_use => false,
  }

  rvm_gem { "${version}-bundler":
    name         => 'bundler',
    ruby_version => "ruby-${version}",
    ensure       => latest,
    require      => Rvm_system_ruby["ruby-${version}"];
  }
}
