class mysql::params {
  $start_server = true
  $allowed_network = '192.168.1.0/24'
  $symbolic_links = 0
  $old_passwords = 0
  $max_allowed_packet = '32M'
  $lower_case_table_names = 0
  $long_query_time = 10
  $innodb_buffer_pool_size = 1000000000
  $key_buffer_size = 200000000
  $query_cache_type = 1
  $query_cache_size = 200000000
  $table_cache = 1000
  $open_files_limit = 3000
  $tmp_table_size = 200000000
  $max_heap_table_size = 300000000
}
