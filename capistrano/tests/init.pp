class { 'capistrano':
  deploy_keys => [ 'ssh-rsa euhf93hnfoef92 me@example.com' ],
  deploy_to => '/var/www/apps',
}
