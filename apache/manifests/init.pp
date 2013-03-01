class apache(
  $timeout                = $apache::params::timeout,
  $keepalive              = hiera('apache::keepalive', $apache::params::keepalive),
  $max_keepalive_requests = $apache::params::max_keepalive_requests,
  $keepalive_timeout      = $apache::params::keepalive_timeout,
  $start_servers          = $apache::params::start_servers,
  $min_spare_servers      = $apache::params::min_spare_servers,
  $max_spare_servers      = $apache::params::max_spare_servers,
  $server_limit           = $apache::params::server_limit,
  $max_requests_per_child = $apache::params::max_requests_per_child,
  $avg_child_memory       = $apache::params::avg_child_memory,
  $reserved_memory        = $apache::params::reserved_memory,
  $max_clients            = $apache::params::max_clients,
  $start_service          = hiera('apache::start_service', $apache::params::start_service)
) inherits apache::params {

  # We need to get system memory in MB as an integer
  if ! $max_clients {
    $sys_mem = inline_template("<%
      mem,unit = scope.lookupvar('::memorysize').split
      mem = mem.to_f
      case unit
          when nil:  mem *= (1<<0)
          when 'kB': mem *= (1<<10)
          when 'MB': mem *= (1<<20)
          when 'GB': mem *= (1<<30)
          when 'TB': mem *= (1<<40)
      end
      %><%= mem.to_i %>") / 1048576
    $max_clients_used = inline_template("<%= ((sys_mem.to_i - reserved_memory.to_i) / avg_child_memory.to_i).floor -%>")
  } else {
    $max_clients_used = $max_clients
  }

  if $keepalive {
    $keepalive_used = 'On'
  } else {
    $keepalive_used = 'Off'
  }

  package { [ 'httpd', 'mod_ssl' ]:
    ensure => present,
  }

  service { 'httpd':
    ensure     => $start_service,
    enable     => $start_service,
    require    => Package['httpd'],
    subscribe  => [
        File['/etc/httpd/conf/httpd.conf'],
        File['/etc/httpd/conf.d/ssl.conf']
    ],
  }

  if defined('firewall::rule') {
    firewall::rule { 'allow-http-server':
      weight => '375',
      rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT',
    }
    firewall::rule { 'allow-https-server':
      weight => '376',
      rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT',
    }
  }

  file { '/etc/httpd/conf/httpd.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['httpd'],
    content => template('apache/httpd.conf.erb'),
  }

  file { '/etc/httpd/conf.d/ssl.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/apache/ssl.conf',
  }

  file { '/etc/httpd/conf/ca-chain.cert':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/apache/ca-chain.cert',
  }
}