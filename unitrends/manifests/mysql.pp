class unitrends::mysql {
  include mysql::backup

  if $unitrends_directory_exists {
    file { '/usr/bp/bin/mysql-backup.sh':
      ensure  => present,
      owner   => 'root', 
      group   => 'bin',
      mode    => '0750',
      source  => "${mysql::backup::backup_path}/backup.sh",
    }
  }
}
