include sudo

sudo::directive { 'admin_users':
  ensure  => present,
  content => "%admin ALL=(ALL) ALL",
}
