class mysql::backup (
  backup_user     => 'backup',
  backup_password => 'password',
  cron            => true,
  purge_days      => '30',
  backup_path     => '/root/mysql',
  hour            => '1',
}
