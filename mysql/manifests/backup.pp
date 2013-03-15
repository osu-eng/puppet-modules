class mysql::backup (
  $backup_user = $mysql::params::backup_user,
  $backup_password = $mysql::params::backup_password,
  $backup_path = $mysql::params::backup_path,
  $purge_days = $mysql::params::purge_days,
  $hour = $mysql::params::hour,
  $cron = hiera('mysql::backup::cron', $mysql::params::cron)
) inherits mysql::params {

  include mysql

  file { "${backup_path}":
    ensure  => directory,
    owner   => 'root', 
    group   => 'root',
    mode    => '0750',
  }

  file { "${backup_path}/backup.sh":
    ensure  => present,
    owner   => 'root', 
    group   => 'root',
    mode    => '0750',
    content => template('mysql/backup.sh.erb'),
  }

  if $cron {
    cron { 'mysql-backup':
      command => "${backup_path}/backup.sh",
      user    => 'root',
      hour    => $hour,
      minute  => 0,
      require => File["${backup_path}/backup.sh"],
    }
  }
}
