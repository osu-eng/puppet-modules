firewall::rule { 'allow-http-server':
  weight => '375',
  table  => 'filter',
  rule   => '-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT',
}
