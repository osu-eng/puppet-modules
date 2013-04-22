class { 'php::apc':
  cache_memory  => 128,
  cache_exclude => ['/var/www/cache-exclude'],
  stat          => true,
}
