class mysql::server (
  $start_server = hiera('mysql::server::start_server', $mysql::params::start_server),
  $allowed_network = $mysql::params::allowed_network,
  $symbolic_links = $mysql::params::symbolic_links,
  $old_passwords = $mysql::params::old_passwords,
  $max_allowed_packet = $mysql::params::max_allowed_packet,
  $lower_case_table_names = $mysql::params::lower_case_table_names,
  $long_query_time = $mysql::params::long_query_time,
  $innodb_buffer_pool_size = $mysql::params::innodb_buffer_pool_size,
  $key_buffer_size = $mysql::params::key_buffer_size,
  $query_cache_type = $mysql::params::query_cache_type,
  $query_cache_size = $mysql::params::query_cache_size,
  $table_cache = $mysql::params::table_cache,
  $open_files_limit = $mysql::params::open_files_limit,
  $tmp_table_size = $mysql::params::tmp_table_size,
  $max_heap_table_size = $mysql::params::max_heap_table_size
) inherits mysql::params {

  include mysql

  package { 'mysql-server':
    ensure => present,
  }

  if $start_server {
    service { 'mysql':
      ensure     => running,
      enable     => true,
      require    => Package['mysql-server'],
      subscribe  => File['/etc/my.cnf'],
    }
  }
  
  file { '/etc/my.cnf':
    ensure  => present,
    owner   => 'root', 
    group   => 'root',
    mode    => '0644',
    require => Package['mysql-server'],
    content => template('mysql/my.cnf.erb'),
  }
  
  if defined('firewall::rule') {
    firewall::rule { 'allow-mysql':
      weight => '725',
      rule   => "-A INPUT -s ${$allowed_network} -p tcp -m multiport --dports 3306 -j ACCEPT",
    }
  }
  
  file { '/root/puppet-mysql-readme.txt':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/mysql/readme.txt',
  }
}